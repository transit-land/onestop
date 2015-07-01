# == Schema Information
#
# Table name: changesets
#
#  id         :integer          not null, primary key
#  notes      :text
#  applied    :boolean
#  applied_at :datetime
#  payload    :json
#  created_at :datetime
#  updated_at :datetime
#

class Changeset < ActiveRecord::Base
  class Error < StandardError
    attr_accessor :changeset, :message, :backtrace

    def initialize(changeset, message, backtrace=[])
      @changeset = changeset
      @message = message
      @backtrace = backtrace
    end
  end

  PER_PAGE = 50

  include CanBeSerializedToCsv

  include HasAJsonPayload

  has_many :stops_created_or_updated, class_name: 'Stop', foreign_key: 'created_or_updated_in_changeset_id'
  has_many :stops_destroyed, class_name: 'OldStop', foreign_key: 'destroyed_in_changeset_id'

  has_many :operators_created_or_updated, class_name: 'Operator', foreign_key: 'created_or_updated_in_changeset_id'
  has_many :operators_destroyed, class_name: 'OldOperator', foreign_key: 'destroyed_in_changeset_id'

  has_many :routes_created_or_updated, class_name: 'Route', foreign_key: 'created_or_updated_in_changeset_id'
  has_many :routes_destroyed, class_name: 'OldRoute', foreign_key: 'destroyed_in_changeset_id'

  has_many :operators_serving_stop_created_or_updated, class_name: 'OperatorServingStop', foreign_key: 'created_or_updated_in_changeset_id'
  has_many :operators_serving_stop_destroyed, class_name: 'OldOperatorServingStop', foreign_key: 'destroyed_in_changeset_id'

  has_many :routes_serving_stop_created_or_updated, class_name: 'RouteServingStop', foreign_key: 'created_or_updated_in_changeset_id'
  has_many :routes_serving_stop_destroyed, class_name: 'OldRouteServingStop', foreign_key: 'destroyed_in_changeset_id'

  def entities_created_or_updated
    # NOTE: this is probably evaluating the SQL queries, rather than merging together ARel relations
    # in Rails 5, there will be an ActiveRecord::Relation.or() operator to use instead here
    (
      stops_created_or_updated +
      operators_created_or_updated +
      routes_created_or_updated +
      operators_serving_stop_created_or_updated +
      routes_serving_stop_created_or_updated
    )
  end
  def entities_destroyed
    (
      stops_destroyed +
      operators_destroyed +
      routes_destroyed +
      operators_serving_stop_destroyed +
      routes_serving_stop_destroyed
    )
  end

  after_initialize :set_default_values

  validate :validate_payload

  onestop_id_format_proc = -> (onestop_id, expected_entity_type) do
    is_a_valid_onestop_id, onestop_id_errors = OnestopId.validate_onestop_id_string(onestop_id, expected_entity_type: expected_entity_type)
    raise JSON::Schema::CustomFormatError.new(onestop_id_errors.join(', ')) if !is_a_valid_onestop_id
  end
  JSON::Validator.schema_reader = JSON::Schema::Reader.new(accept_uri: false, accept_file: true)
  JSON::Validator.register_format_validator('operator-onestop-id', -> (onestop_id) {
    onestop_id_format_proc.call(onestop_id, 'operator')
  })
  JSON::Validator.register_format_validator('stop-onestop-id', -> (onestop_id) {
    onestop_id_format_proc.call(onestop_id, 'stop')
  })

  def trial_succeeds?
    trial_succeeds = false
    Changeset.transaction do
      begin
        apply!
      rescue Exception => e
        raise ActiveRecord::Rollback
      else
        trial_succeeds = true
        raise ActiveRecord::Rollback
      end
    end
    self.reload
    trial_succeeds
  end

  def apply!
    if applied
      raise Changeset::Error.new(self, 'has already been applied.')
    else
      Changeset.transaction do
        begin
          payload_as_ruby_hash[:changes].each do |change|
            if change[:stop].present?
              Stop.apply_change(changeset: self, attrs: change[:stop], action: change[:action])
            end
            if change[:operator].present?
              Operator.apply_change(changeset: self, attrs: change[:operator], action: change[:action])
            end
            if change[:route].present?
              Route.apply_change(changeset: self, attrs: change[:route], action: change[:action])
            end
          end
          self.update(applied: true, applied_at: Time.now)
        rescue
          raise Changeset::Error.new(self, $!.message, $!.backtrace)
        end
      end
      # Now that the transaction is complete and has been committed,
      # we can do some async tasks like conflate stops with OSM.
      if Figaro.env.auto_conflate_stops_with_osm.present? &&
         Figaro.env.auto_conflate_stops_with_osm == 'true' &&
         self.stops_created_or_updated.count > 0
        ConflateStopsWithOsmWorker.perform_async(self.stops_created_or_updated.map(&:id))
      end
      true
    end
  end

  def revert!
    if applied
      # TODO: write it
      raise Changeset::Error.new(self, "cannot revert. This functionality doesn't exist yet.")
    else
      raise Changeset::Error.new(self, 'cannot revert. This changeset has not been applied yet.')
    end
  end

  def bounding_box
    # TODO: write it
  end

  def append_change(change)
    payload['changes'].push(change)
    self.update(payload: payload)
  end

  private

  def set_default_values
    if self.new_record?
      self.applied ||= false
      self.payload ||= {changes:[]}
    end
  end

  def validate_payload
    payload_validation_errors = JSON::Validator.fully_validate(
      File.join(__dir__, 'json_schemas', 'changeset.json'),
      self.payload,
      errors_as_objects: true
    )
    if payload_validation_errors.length > 0
      payload_validation_errors.each do |error|
        errors.add(:payload, error[:message])
      end
      false
    else
      true
    end
  end

end
