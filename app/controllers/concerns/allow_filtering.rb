module AllowFiltering
  extend ActiveSupport::Concern

  def self.by_onestop_id(collection, params)
    if params[:onestop_id].present? || params[:ids].present?
      onestop_ids = []
      if params[:onestop_id].present?
        if params[:onestop_id].is_a?(Array) # for Ember Data
          onestop_ids += params[:onestop_id]
        elsif params[:onestop_id].is_a?(String)
          onestop_ids += params[:onestop_id].split(',')
        end
      end
      if params[:ids].present?
        if params[:ids].is_a?(Array) # for Ember Data
          onestop_ids += params[:ids]
        elsif params[:ids].is_a?(String)
          onestop_ids += params[:ids].split(',')
        end
      end
      collection = collection.find_by_onestop_ids!(onestop_ids)
    end
    collection
  end

  def self.by_primary_key_ids(collection, params)
    if params[:ids].present?
      if params[:ids].is_a?(Array) # for Ember Data
        ids = params[:ids]
      elsif params[:ids].is_a?(String)
        ids = params[:ids].split(',')
      end
      collection = collection.where(id: ids)
    end
    collection
  end

  def self.by_tag_keys_and_values(collection, params)
    if params[:tag_key].present? && params[:tag_value].present?
      collection = collection.with_tag_equals(params[:tag_key], params[:tag_value])
    end
    if params[:tag_key].present?
      collection = collection.with_tag(params[:tag_key])
    end
    collection
  end

  def self.by_updated_since(collection, params)
    if params[:updated_since].present?
      collection = collection.updated_since(params[:updated_since])
    end
    collection
  end

  def self.by_identifer_and_identifier_starts_with(collection, params)
    if params[:identifier].present?
      collection = collection.with_identifier_or_name(params[:identifier])
    elsif params[:identifier_starts_with].present?
      collection = collection.with_identifier_starting_with(params[:identifier_starts_with])
    end
    collection
  end

  def self.by_boolean_attribute(collection, params, boolean_attribute_name)
    unless params[boolean_attribute_name].nil?
      conditions = {}
      conditions[boolean_attribute_name] = to_boolean(params[boolean_attribute_name])
      collection = collection.where(conditions)
    end
    collection
  end

  def self.by_attribute_since(collection, params, param_name, attribute_name=nil)
    value = params[param_name]
    attribute_name ||= param_name
    if value.present?
      value = value.is_a?(DateTime) ? value : DateTime.parse(value)
      collection = collection.where(
        collection.arel_table[attribute_name].gteq(value)
      )
    end
    collection
  end

  def self.by_attribute_array(collection, params, attribute_name, case_sensitive=false)
    values = param_as_array(params, attribute_name)
    if case_sensitive
      t = collection.arel_table[attribute_name].in(values)
    else
      t = collection.arel_table[attribute_name].lower.in(values.map(&:downcase))
    end
    if values.present?
      collection = collection.where(t)
    end
    collection
  end

  def self.param_as_array(params, attribute_name)
    values = []
    value = params[attribute_name]
    if value.present?
      (values += value) if value.is_a?(Array)
      (values += value.split(',')) if value.is_a?(String)
    end
    values
  end

  def self.to_boolean(value)
    case value
      when 'true' then true
      when true then true
      when 1 then true
      when '1' then true
      when 'false' then false
      when false then false
      when 0 then false
      when '0' then false
      when nil then false
    end
  end

end
