# == Schema Information
#
# Table name: current_schedule_stop_pairs
#
#  id                                 :integer          not null, primary key
#  origin_id                          :integer
#  destination_id                     :integer
#  route_id                           :integer
#  trip                               :string
#  created_or_updated_in_changeset_id :integer
#  version                            :integer
#  trip_headsign                      :string
#  origin_arrival_time                :string
#  origin_departure_time              :string
#  destination_arrival_time           :string
#  destination_departure_time         :string
#  frequency_start_time               :string
#  frequency_end_time                 :string
#  frequency_headway_seconds          :string
#  tags                               :hstore
#  service_start_date                 :date
#  service_end_date                   :date
#  service_added_dates                :date             default([]), is an Array
#  service_except_dates               :date             default([]), is an Array
#  service_days_of_week               :boolean          default([]), is an Array
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  block_id                           :string
#  trip_short_name                    :string
#  shape_dist_traveled                :float
#  origin_timezone                    :string
#  destination_timezone               :string
#  window_start                       :string
#  window_end                         :string
#  origin_timepoint_source            :string
#  destination_timepoint_source       :string
#  operator_id                        :integer
#  wheelchair_accessible              :boolean
#  bikes_allowed                      :boolean
#  pickup_type                        :string
#  drop_off_type                      :string
#  active                             :boolean
#
# Indexes
#
#  c_ssp_cu_in_changeset                                       (created_or_updated_in_changeset_id)
#  c_ssp_destination                                           (destination_id)
#  c_ssp_origin                                                (origin_id)
#  c_ssp_route                                                 (route_id)
#  c_ssp_service_end_date                                      (service_end_date)
#  c_ssp_service_start_date                                    (service_start_date)
#  c_ssp_trip                                                  (trip)
#  index_current_schedule_stop_pairs_on_active                 (active)
#  index_current_schedule_stop_pairs_on_operator_id            (operator_id)
#  index_current_schedule_stop_pairs_on_origin_departure_time  (origin_departure_time)
#  index_current_schedule_stop_pairs_on_updated_at             (updated_at)
#

class BaseScheduleStopPair < ActiveRecord::Base
  self.abstract_class = true
  PER_PAGE = 50
  include IsAnEntityImportedFromFeeds

  extend Enumerize
  enumerize :origin_timepoint_source, in: [
      :gtfs_exact,
      :gtfs_interpolated,
      :transitland_interpolated_linear,
      :transitland_interpolated_geometric,
      :transitland_interpolated_shape
    ]
  enumerize :destination_timepoint_source, in: [
      :gtfs_exact,
      :gtfs_interpolated,
      :transitland_interpolated_linear,
      :transitland_interpolated_geometric,
      :transitland_interpolated_shape
    ]
end

class ScheduleStopPair < BaseScheduleStopPair
  self.table_name_prefix = 'current_'

  # Relations to stops and routes
  belongs_to :origin, class_name: "Stop"
  belongs_to :destination, class_name: "Stop"
  belongs_to :route
  belongs_to :operator

  # Required relations and attributes
  before_validation :filter_service_range
  validates :origin,
            :destination,
            :route,
            :operator,
            :trip,
            :origin_timezone,
            :destination_timezone,
            :origin_arrival_time,
            :origin_departure_time,
            :destination_arrival_time,
            :destination_departure_time,
            :service_start_date,
            :service_end_date,
            presence: true
  validate :validate_service_range
  validate :validate_service_exceptions

  # Add scope for updated_since
  include UpdatedSince

  # Scopes
  # Service active on a date
  scope :where_service_on_date, -> (date) {
    date = date.is_a?(Date) ? date : Date.parse(date)
    # ISO week day is Monday = 1, Sunday = 7; Postgres arrays are indexed at 1
    where("(service_start_date <= ? AND service_end_date >= ?) AND (true = service_days_of_week[?] OR ? = ANY(service_added_dates)) AND NOT (? = ANY(service_except_dates))", date, date, date.cwday, date, date)
  }

  scope :where_origin_departure_between, -> (time1, time2) {
    time1 = (GTFS::WideTime.parse(time1) || '00:00:00').to_s
    time2 = (GTFS::WideTime.parse(time2) || '99:59:59').to_s
    where("origin_departure_time >= ? AND origin_departure_time <= ?", time1, time2)
  }

  # Current service, and future service, active from a date
  scope :where_service_from_date, -> (date) {
    date = date.is_a?(Date) ? date : Date.parse(date)
    where("service_end_date >= ?", date)
  }

  # Service trips_out in a bbox
  scope :where_origin_bbox, -> (bbox) {
    # use Squeel gem to run a subquery
    where{origin_id.in(Stop.within_bbox(bbox).select{id})}
  }

  # Handle mapping from onestop_id to id
  def route_onestop_id=(value)
    self.route = Route.find_by!(onestop_id: value)
    self.operator = route.operator
  end

  def origin_onestop_id=(value)
    self.origin = Stop.find_by!(onestop_id: value)
  end

  def destination_onestop_id=(value)
    self.destination = Stop.find_by!(onestop_id: value)
  end

  def service_on_date?(date)
    date = Date.parse(date) unless date.is_a?(Date)
    # the -1 is because ISO week day is Monday = 1, Sunday = 7
    date.between?(service_start_date, service_end_date) && (service_days_of_week[date.cwday-1] == true || service_added_dates.include?(date)) && (!service_except_dates.include?(date))
  end

  # Service exceptions
  def service_except_dates=(dates)
    super(dates.map { |x| x.is_a?(Date) ? x : Date.parse(x) }.uniq)
  end

  def service_added_dates=(dates)
    super(dates.map { |x| x.is_a?(Date) ? x : Date.parse(x) }.uniq)
  end

  def origin_arrival_time=(value)
    super(GTFS::WideTime.parse(value))
  end

  def origin_departure_time=(value)
    super(GTFS::WideTime.parse(value))
  end

  def destination_arrival_time=(value)
    super(GTFS::WideTime.parse(value))
  end

  def destination_departure_time=(value)
    super(GTFS::WideTime.parse(value))
  end

  # Tracked by changeset
  include CurrentTrackedByChangeset
  current_tracked_by_changeset({
    kind_of_model_tracked: :relationship,
    virtual_attributes: [
      :origin_onestop_id,
      :destination_onestop_id,
      :route_onestop_id,
      :imported_from_feed
    ]
  })
  def self.find_by_attributes(attrs = {})
    if attrs[:id].present?
      find(attrs[:id])
    end
  end
  def self.apply_params(params, cache={})
    params = super(params, cache)
    {
      origin_onestop_id: :origin,
      destination_onestop_id: :destination,
      route_onestop_id: :route
    }.each do |k,v|
      cache[params[k]] ||= OnestopId.find!(params[k])
      params[v] = cache[params.delete(k)]
    end
    if params[:imported_from_feed]
      feed_onestop_id = params[:imported_from_feed][:onestop_id]
      feed_version_id = params[:imported_from_feed][:sha1]
      cache[feed_onestop_id] ||= OnestopId.find!(feed_onestop_id)
      cache[feed_version_id] ||= cache[feed_onestop_id].feed_versions.find_by!(sha1: feed_version_id)
      params[:imported_from_feed][:feed] = cache[feed_onestop_id]
      params[:imported_from_feed][:feed_version] = cache[feed_version_id]
    end
    params[:operator] = params[:route].operator
    params
  end

  # Interpolate
  def self.interpolate(ssps, method=:linear)
    groups = []
    group = []
    ssps.each do |ssp|
      group << ssp
      if ssp.destination_arrival_time
        groups << group
        group = []
      end
    end
    if method == :linear
      groups.each { |group| self.interpolate_linear(group) }
    else
      raise ArgumentError.new("Unknown interpolation method: #{method}")
    end
  end

  private

  def self.interpolate_linear(group)
    window_start = GTFS::WideTime.parse(group.first.origin_departure_time)
    window_end = GTFS::WideTime.parse(group.last.destination_arrival_time)
    duration = window_end.to_seconds - window_start.to_seconds
    step = duration / group.size.to_f
    current = window_start.to_seconds
    # Set first/last stop
    group.first.origin_timepoint_source = :gtfs_exact
    group.first.window_start = window_start
    group.first.window_end = window_end
    group.last.destination_timepoint_source = :gtfs_exact
    group.last.window_start = window_start
    group.last.window_end = window_end
    # Interpolate
    group[0..-2].zip(group[1..-1]) do |a,b|
      current += step
      t = GTFS::WideTime.new(current.to_i).to_s
      #
      a.window_start = window_start
      a.window_end = window_end
      a.destination_arrival_time = t
      a.destination_departure_time = t
      a.destination_timepoint_source = :transitland_interpolated_linear
      # Next stop
      b.window_start = window_start
      b.window_end = window_end
      b.origin_arrival_time = t
      b.origin_departure_time = t
      b.origin_timepoint_source = :transitland_interpolated_linear
    end
  end

  # Set a service range from service_added_dates, service_except_dates
  def expand_service_range
    self.service_start_date ||= (service_except_dates + service_added_dates).min
    self.service_end_date ||= (service_except_dates + service_added_dates).max
    true
  end

  def filter_service_range
    expand_service_range
    self.service_added_dates = service_added_dates.select { |x| x.between?(service_start_date, service_end_date)}.sort
    self.service_except_dates = service_except_dates.select { |x| x.between?(service_start_date, service_end_date)}.sort
  end

  # Make sure service_start_date < service_end_date
  def validate_service_range
    if service_start_date && service_end_date
      errors.add(:service_start_date, "service_start_date begins after service_end_date") if service_start_date > service_end_date
    end
  end

  # Require service_added_dates to be in service range
  def validate_service_exceptions
    if !service_added_dates.reject { |x| x.between?(service_start_date, service_end_date)}.empty?
      errors.add(:service_added_dates, "service_added_dates must be within service_start_date, service_end_date range")
    end
    if !service_except_dates.reject { |x| x.between?(service_start_date, service_end_date)}.empty?
      errors.add(:service_except_dates, "service_except_dates must be within service_start_date, service_end_date range")
    end
  end
end

class OldScheduleStopPair < BaseScheduleStopPair
  include OldTrackedByChangeset
  belongs_to :stop, polymorphic: true
end
