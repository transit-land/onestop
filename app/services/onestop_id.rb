require 'addressable/template'

class OnestopId
  ENTITY_TO_PREFIX = {
    'stop' => 's',
    'stopstation' => 's',
    'stopplatform' => 's',
    'stopentrance' => 's',
    'operator' => 'o',
    'feed' => 'f',
    'route' => 'r'
  }
  PREFIX_TO_ENTITY = ENTITY_TO_PREFIX.invert
  PREFIX_TO_MODEL = {
    's' => Stop,
    'o' => Operator,
    'r' => Route,
    'f' => Feed
  }
  MODEL_TO_PREFIX = PREFIX_TO_MODEL.invert
  COMPONENT_SEPARATOR = '-'
  GEOHASH_FILTER = /[^0123456789bcdefghjkmnpqrstuvwxyz]/
  NAME_TILDE = /[\-\:\&\@\/]/
  NAME_FILTER = /[^a-zA-Z\d\@\~]/
  IDENTIFIER_TEMPLATE = Addressable::Template.new("gtfs://{feed_onestop_id}/{entity_prefix}/{entity_id}")

  attr_accessor :entity_prefix, :geohash, :name

  def initialize(string: nil, entity_prefix: nil, geohash: nil, name: nil)
    if string && string.length > 0
      @entity_prefix = string.split(COMPONENT_SEPARATOR)[0]
      @geohash = string.split(COMPONENT_SEPARATOR)[1]
      @name = string.split(COMPONENT_SEPARATOR)[2]
    elsif entity_prefix && geohash && name
      # Filter geohash and name; validate later
      @entity_prefix = entity_prefix
      @geohash = geohash_filter(geohash)
      @name = name_filter(name)
    else
      raise ArgumentError.new('either a string or entity/geohash/name must be specified')
    end
    # Check valid OnestopID
    is_a_valid_onestop_id, errors = OnestopId.validate_onestop_id_string(self.to_s)
    if !is_a_valid_onestop_id
      raise ArgumentError.new(errors.join(', '))
    end
    self
  end

  def to_s
    [@entity_prefix, @geohash, @name].join(COMPONENT_SEPARATOR)
  end

  def self.create_identifier(feed_onestop_id, entity_prefix, entity_id)
    IDENTIFIER_TEMPLATE.expand(
      feed_onestop_id: feed_onestop_id,
      entity_prefix: entity_prefix,
      entity_id: entity_id
    ).to_s
  end

  def self.validate_onestop_id_string(onestop_id, expected_entity_type: nil)
    errors = []
    is_a_valid_onestop_id = true

    if onestop_id.blank?
      return false, ['must not be blank']
    end

    if onestop_id.split(COMPONENT_SEPARATOR).length != 3
      errors << 'must include 3 components separated by hyphens ("-")'
      is_a_valid_onestop_id = false
    end

    if expected_entity_type && onestop_id.split(COMPONENT_SEPARATOR)[0] != ENTITY_TO_PREFIX[expected_entity_type]
      errors << "must start with \"#{ENTITY_TO_PREFIX[expected_entity_type]}\" as its 1st component"
      is_a_valid_onestop_id = false
    elsif expected_entity_type == nil && !valid_component?(:entity_prefix, onestop_id.split(COMPONENT_SEPARATOR)[0])
      errors << "must start with \"#{ENTITY_TO_PREFIX.values.join(' or ')}\" as its 1st component"
      is_a_valid_onestop_id = false
    end

    if onestop_id.split(COMPONENT_SEPARATOR)[1].length == 0 || !valid_component?(:geohash, onestop_id.split(COMPONENT_SEPARATOR)[1])
      errors << 'must include a valid geohash as its 2nd component'
      is_a_valid_onestop_id = false
    end

    if !valid_component?(:name, onestop_id.split(COMPONENT_SEPARATOR)[2])
      errors << 'must include only letters, digits, and ~ or @ in its abbreviated name (the 3rd component)'
      is_a_valid_onestop_id = false
    end
    return is_a_valid_onestop_id, errors
  end

  def self.find(onestop_id)
    OnestopId::PREFIX_TO_MODEL[onestop_id.split(OnestopId::COMPONENT_SEPARATOR)[0]].find_by(onestop_id: onestop_id)
  end

  def self.find!(onestop_id)
    OnestopId::PREFIX_TO_MODEL[onestop_id.split(OnestopId::COMPONENT_SEPARATOR)[0]].find_by!(onestop_id: onestop_id)
  end

  private

  def name_filter(value)
    value.downcase.gsub(NAME_TILDE, '~').gsub(NAME_FILTER, '')
  end

  def geohash_filter(value)
    value.downcase.gsub(GEOHASH_FILTER, '')
  end

  def self.valid_component?(component, value)
    return false if !value || value.length == 0
    case component
    when :entity_prefix
      ENTITY_TO_PREFIX.values.include?(value)
    when :geohash
      !(value =~ GEOHASH_FILTER)
    when :name
      !(value =~ NAME_FILTER)
    else
      false
    end
  end
end
