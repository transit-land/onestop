# == Schema Information
#
# Table name: current_feeds
#
#  id                                 :integer          not null, primary key
#  onestop_id                         :string
#  url                                :string
#  feed_format                        :string
#  tags                               :hstore
#  last_fetched_at                    :datetime
#  last_imported_at                   :datetime
#  license_name                       :string
#  license_url                        :string
#  license_use_without_attribution    :string
#  license_create_derived_product     :string
#  license_redistribute               :string
#  version                            :integer
#  created_at                         :datetime
#  updated_at                         :datetime
#  created_or_updated_in_changeset_id :integer
#  geometry                           :geography({:srid geometry, 4326
#  latest_fetch_exception_log         :text
#  license_attribution_text           :text
#  active_feed_version_id             :integer
#  edited_attributes                  :string           default([]), is an Array
#
# Indexes
#
#  index_current_feeds_on_active_feed_version_id              (active_feed_version_id)
#  index_current_feeds_on_created_or_updated_in_changeset_id  (created_or_updated_in_changeset_id)
#  index_current_feeds_on_geometry                            (geometry)
#  index_current_feeds_on_onestop_id                          (onestop_id) UNIQUE
#

class BaseFeed < ActiveRecord::Base
  self.abstract_class = true

  extend Enumerize
  enumerize :feed_format, in: [:gtfs]
  enumerize :license_use_without_attribution, in: [:yes, :no, :unknown]
  enumerize :license_create_derived_product, in: [:yes, :no, :unknown]
  enumerize :license_redistribute, in: [:yes, :no, :unknown]

  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, if: Proc.new { |feed| feed.url.present? }
  validates :license_url, format: { with: URI.regexp }, if: Proc.new { |feed| feed.license_url.present? }

  attr_accessor :includes_operators, :does_not_include_operators
end

class Feed < BaseFeed
  self.table_name_prefix = 'current_'

  include HasAOnestopId
  include HasTags
  include UpdatedSince
  include HasAGeographicGeometry

  has_many :feed_versions, -> { order 'created_at DESC' }, dependent: :destroy, as: :feed
  has_many :feed_version_imports, -> { order 'created_at DESC' }, through: :feed_versions
  belongs_to :active_feed_version, class_name: 'FeedVersion'

  has_many :operators_in_feed
  has_many :operators, through: :operators_in_feed

  has_many :entities_imported_from_feed
  has_many :imported_operators, through: :entities_imported_from_feed, source: :entity, source_type: 'Operator'
  has_many :imported_stops, through: :entities_imported_from_feed, source: :entity, source_type: 'Stop'
  has_many :imported_routes, through: :entities_imported_from_feed, source: :entity, source_type: 'Route'
  has_many :imported_schedule_stop_pairs, through: :entities_imported_from_feed, source: :entity, source_type: 'ScheduleStopPair'
  has_many :imported_route_stop_patterns, through: :entities_imported_from_feed, source: :entity, source_type: 'RouteStopPattern'
  has_many :imported_schedule_stop_pairs, class_name: 'ScheduleStopPair', dependent: :delete_all

  has_many :changesets_imported_from_this_feed, class_name: 'Changeset'

  after_initialize :set_default_values

  scope :where_latest_fetch_exception, -> (flag) {
    if flag
      where.not(latest_fetch_exception_log: nil)
    else
      where(latest_fetch_exception_log: nil)
    end
  }

  scope :where_active_feed_version_import_level, -> (import_level) {
    import_level = import_level.to_i
    joins(:active_feed_version)
      .where('feed_versions.import_level = ?', import_level)
  }

  scope :where_active_feed_version_valid, -> (date) {
    date = date.is_a?(Date) ? date : Date.parse(date)
    joins(:active_feed_version)
      .where('feed_versions.latest_calendar_date > ?', date)
      .where('feed_versions.earliest_calendar_date < ?', date)
  }

  scope :where_active_feed_version_expired, -> (date) {
    date = date.is_a?(Date) ? date : Date.parse(date)
    joins(:active_feed_version)
      .where('feed_versions.latest_calendar_date < ?', date)
  }

  scope :where_active_feed_version_update, -> {
    # Find feeds that have a feed_version newer than
    #   the current active_feed_version
    joins(p %{
      INNER JOIN (
        SELECT DISTINCT feed_versions.feed_id
        FROM feed_versions
        INNER JOIN (
          SELECT feed_versions.feed_id AS feed_id, feed_versions.created_at AS created_at_active
          FROM feed_versions
          INNER JOIN current_feeds ON current_feeds.active_feed_version_id = feed_versions.id
          GROUP BY feed_versions.feed_id, feed_versions.created_at
        ) feed_versions_active ON feed_versions.feed_id = feed_versions_active.feed_id
        WHERE feed_versions.created_at > feed_versions_active.created_at_active
      ) feeds_superseded
      ON current_feeds.id = feeds_superseded.feed_id
    })
  }

  include CurrentTrackedByChangeset
  current_tracked_by_changeset({
    kind_of_model_tracked: :onestop_entity,
    virtual_attributes: [
      :includes_operators,
      :does_not_include_operators
    ],
    protected_attributes: [
      :identifiers
    ]
  })
  def after_create_making_history(changeset)
    (self.includes_operators || []).each do |included_operator|
      operator = Operator.find_by!(onestop_id: included_operator[:operator_onestop_id])
      OperatorInFeed.create_making_history(
        changeset: changeset,
        new_attrs: {
          feed_id: self.id,
          operator_id: operator.id,
          gtfs_agency_id: included_operator[:gtfs_agency_id]
        }
      )
    end
    # No need to iterate through self.does_not_include_operators
    # since this is a brand new feed model.
  end
  def before_update_making_history(changeset)
    (self.includes_operators || []).each do |included_operator|
      operator = Operator.find_by!(onestop_id: included_operator[:operator_onestop_id])
      existing_relationship = OperatorInFeed.find_by(operator: operator, feed: self)
      if existing_relationship
          existing_relationship.update_making_history(
            changeset: changeset,
            new_attrs: {
              feed_id: self.id,
              operator_id: operator.id,
              gtfs_agency_id: included_operator[:gtfs_agency_id]
            }
          )
      else
        OperatorInFeed.create_making_history(
          changeset: changeset,
          new_attrs: {
            feed_id: self.id,
            operator_id: operator.id,
            gtfs_agency_id: included_operator[:gtfs_agency_id]
          }
        )
      end
    end
    (self.does_not_include_operators || []).each do |not_included_operator|
      operator = Operator.find_by!(onestop_id: not_included_operator[:operator_onestop_id])
      existing_relationship = OperatorInFeed.find_by(operator: operator, feed: self)
      if existing_relationship
        existing_relationship.destroy_making_history(changeset: changeset)
      end
    end
    super(changeset)
  end
  def before_destroy_making_history(changeset, old_model)
    operators_in_feed.each do |operator_in_feed|
      operator_in_feed.destroy_making_history(changeset: changeset)
    end
    return true
  end

  def find_next_feed_version(date)
    # Find a feed_version where:
    #   1. newer than active_feed_version
    #   2. service begins on or later than active_feed_version
    #   3. service begins on or before specified date
    active_feed_version = self.active_feed_version
    return unless active_feed_version
    self.feed_versions
      .where('created_at > ?', active_feed_version.created_at)
      .where('earliest_calendar_date >= ?', active_feed_version.earliest_calendar_date)
      .where('earliest_calendar_date <= ?', date)
      .reorder(earliest_calendar_date: :desc, created_at: :desc)
      .first
  end

  def activate_feed_version(feed_version_sha1, import_level)
    feed_version = self.feed_versions.find_by!(sha1: feed_version_sha1)
    self.transaction do
      self.update!(active_feed_version: feed_version)
      feed_version.update!(import_level: import_level)
    end
  end

  def deactivate_feed_version(feed_version_sha1)
    feed_version = self.feed_versions.find_by!(sha1: feed_version_sha1)
    if feed_version == self.active_feed_version
      fail ArgumentError.new('Cannot deactivate current active_feed_version')
    else
      feed_version.delete_schedule_stop_pairs!
    end
  end

  def set_bounding_box_from_stops(stops)
    stop_features = Stop::GEOFACTORY.collection(stops.map { |stop| stop.geometry(as: :wkt) })
    bounding_box = RGeo::Cartesian::BoundingBox.create_from_geometry(stop_features)
    self.geometry = bounding_box.to_geometry
  end

  def import_status
    if self.last_imported_at.blank? && self.feed_version_imports.count == 0
      :never_imported
    elsif self.feed_version_imports.first.success == false
      :most_recent_failed
    elsif self.feed_version_imports.first.success == true
      :most_recent_succeeded
    elsif self.feed_version_imports.first.success == nil
      :in_progress
    else
      :unknown
    end
  end

  ##### FromGTFS ####
  include FromGTFS
  def self.from_gtfs(entity, attrs={})
    # Entity is a feed.
    visited_stops = Set.new
    entity.agencies.each { |agency| visited_stops |= agency.stops }
    coordinates = Stop::GEOFACTORY.collection(
      visited_stops.map { |stop| Stop::GEOFACTORY.point(*stop.coordinates) }
    )
    geohash = GeohashHelpers.fit(coordinates)
    geometry = RGeo::Cartesian::BoundingBox.create_from_geometry(coordinates)
    # Generate third Onestop ID component
    feed_id = nil
    if entity.file_present?('feed_info.txt')
      feed_info = entity.feed_infos.first
      feed_id = feed_info.feed_id if feed_info
    end
    name_agencies = entity.agencies.select { |agency| agency.stops.size > 0 }.map(&:agency_name).join('~')
    name_url = Addressable::URI.parse(attrs[:url]).host.gsub(/[^a-zA-Z0-9]/, '') if attrs[:url]
    name = feed_id.presence || name_agencies.presence || name_url.presence || 'unknown'
    # Create Feed
    attrs[:geometry] = geometry.to_geometry
    attrs[:onestop_id] = OnestopId.handler_by_model(self).new(
      geohash: geohash,
      name: name
    )
    feed = Feed.new(attrs)
    feed.tags ||= {}
    feed.tags[:feed_id] = feed_id if feed_id
    feed
  end

  private

  def set_default_values
    if self.new_record?
      self.tags ||= {}
      self.feed_format ||= 'gtfs'
      self.license_use_without_attribution ||= 'unknown'
      self.license_create_derived_product ||= 'unknown'
      self.license_redistribute ||= 'unknown'
    end
  end
end

class OldFeed < BaseFeed
  include OldTrackedByChangeset

  has_many :old_operators_in_feed, as: :feed
  has_many :operators, through: :old_operators_in_feed, source_type: 'Feed'
end
