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

    def initialize(changeset, message, backtrace=nil)
      @changeset = changeset
      @message = message
      @backtrace = backtrace
    end
  end

  include HasAJsonPayload

  attr_accessor :when_to_apply

  has_many :stops
  has_many :operators
  has_many :operators_serving_stop
  has_many :identifiers

  validate :validate_payload

  onestop_id_format_proc = -> (onestop_id) do
    is_a_valid_onestop_id, onestop_id_errors = OnestopId.valid?(onestop_id)
    if !is_a_valid_onestop_id
      error_description = onestop_id_errors.join(', ')
      raise JSON::Schema::CustomFormatError.new(error_description)
    end
  end
  JSON::Validator.register_format_validator('onestop_id', onestop_id_format_proc)

  def is_valid_and_can_be_cleanly_applied?
    valid_payload_and_clean_application = validate_payload
    Changeset.transaction do
      begin
        apply!
      rescue
        valid_payload_and_clean_application = false
      end
      raise ActiveRecord::Rollback
    end
    valid_payload_and_clean_application
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
          end
          self.update(applied: true)
          return true
        rescue
          raise Changeset::Error.new(self, $!.message, $!.backtrace)
        end
      end
    end
  end

  def revert
    if applied
      # TODO: write it
    else
      raise Changeset::Error.new(self, 'cannot revert. This changeset has not been applied yet.')
    end
  end

  def bounding_box
    # TODO: write it
  end

  private

  def validate_payload
    payload_validation_errors = JSON::Validator.fully_validate(
      File.join(__dir__, 'json_schemas', 'changeset.json'),
      self.payload,
      errors_as_objects: true
    )
    if payload_validation_errors.length > 0
      errors.add(:payload, payload_validation_errors.map { |error| error[:message] })
      false
    else
      true
    end
  end

end
