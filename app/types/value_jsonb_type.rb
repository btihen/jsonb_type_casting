class ValueJsonbType < ActiveModel::Type::Value
  # include ActiveModel::Type::Helpers::Mutable

  def type
    :jsonb
  end

  def value_key
    raise NotImplemented
  end

  def klass
    raise NotImplemented
  end

  # def accessor
  #   ActiveRecord::Store::StringKeyedHashAccessor
  # end

  def changed_in_place?(raw_old_value, new_value)
    cast_value(raw_old_value) != new_value
  end

  def cast(value)
    case value
    when klass
      value
    when Hash
      attributes = value.with_indifferent_access
      klass.new(attributes.with_indifferent_access)
      # klass.new(attributes[value_key] || attributes[:value] || {})
    when String
      attributes = (ActiveSupport::JSON.decode(value) rescue nil) || {}
      klass.new(attributes.with_indifferent_access)
      # klass.new(attributes[value_key] || attributes[:value] || {})
    when NilClass
      klass.new
    else # string, integer, float, etc
      klass.new({value: value})
    end
  end

  def serialize(value)
    if value.blank?
      ActiveSupport::JSON.encode( {} )
    elsif value.is_a? Hash
      attributes = value.with_indifferent_access
      ActiveSupport::JSON.encode(attributes[value_key] || attributes[:value] || {})
    elsif value.is_a? ValueObject
      ActiveSupport::JSON.encode(value.attributes || {})
    else
      super
    end
  end
end

# # http://til.obiefernandez.com/posts/8c31a92080-rails-5-attributes-api-jsonb-postgres-columns
# class JsonbType < ActiveModel::Type::Value
#   include ActiveModel::Type::Helpers::Mutable
#
#   def type
#     :jsonb
#   end
#
#   def deserialize(value)
#     if value.is_a?(::String)
#       Oj.load(value) rescue nil
#     else
#       value
#     end
#   end
#
#   def serialize(value)
#     if value.nil?
#       nil
#     else
#       Oj.dump(value)
#     end
#   end
#
#   def accessor
#     ActiveRecord::Store::StringKeyedHashAccessor
#   end
# end
