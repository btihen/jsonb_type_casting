class ValueJsonbType < ActiveModel::Type::Value
  # # http://til.obiefernandez.com/posts/8c31a92080-rails-5-attributes-api-jsonb-postgres-columns
  # Oj is very fast - recommended by obiefernandez
  # Oj cast:      attributes = (Oj.load(value) rescue nil) || {}
  # Oj serialize: Oj.dump(attributes || {})
  # if mutable is needed (hmmm?)
  # include ActiveModel::Type::Helpers::Mutable
  # should allow with_indifferent_access - but didn't help
  # def accessor
  #   ActiveRecord::Store::StringKeyedHashAccessor
  # end

  def base_klass
    raise NotImplemented, "base_klass must be defined"
  end

  def type
    :jsonb
  end

  def changed_in_place?(raw_old_value, new_value)
    cast_value(raw_old_value) != new_value
  end

  def cast(value)
    case value
    when base_klass
      value
    when Hash
      base_klass.new(value.with_indifferent_access)
    when String
      # attributes = (Oj.load(value) rescue nil) || {}
      attributes = (ActiveSupport::JSON.decode(value) rescue nil) || {}
      base_klass.new(attributes.with_indifferent_access)
    when NilClass
      base_klass.new
    else # string, integer, float, etc
      base_klass.new(value)
    end
  end

  def serialize(value)
    if value.blank?
      ActiveSupport::JSON.encode( {} )
    elsif value.is_a? Hash
      attributes = value.reject {|_attr, val| val.blank?}
      ActiveSupport::JSON.encode(attributes || {})
    elsif value.is_a? ValueObjectBase
      attributes = value.attributes.reject {|_attr, val| val.blank?}
      ActiveSupport::JSON.encode(attributes || {})
      # Oj.dump(attributes || {})
    else
      super
    end
  end
end
