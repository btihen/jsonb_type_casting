class TemperatureJsonbType < ValueJsonbType

    # def type
    #   :jsonb
    # end

    def klass
      Temperature
    end

    def value_key
      :degrees
    end

    # def accessor
    #   ActiveRecord::Store::StringKeyedHashAccessor
    # end

    # def changed_in_place?(raw_old_value, new_value)
    #   cast_value(raw_old_value) != new_value
    # end
    #
    # def cast(value)
    #   case value
    #
    #   when NilClass
    #     klass.new
    #
    #   when Hash
    #     Temperature.new(value.with_indifferent_access)
    #
    #   when String
    #     attributes = (ActiveSupport::JSON.decode(value) rescue nil) || {}
    #     Temperature.new(attributes.with_indifferent_access)
    #
    #   when Temperature
    #     value
    #
    #   when Integer, Float
    #     klass.new(value)
    #   end
    # end

    # def serialize(value)
    #   if value.blank?
    #     ActiveSupport::JSON.encode({})
    #   elsif value.is_a? Hash
    #     attributes = value.with_indifferent_access
    #     ActiveSupport::JSON.encode(attributes.select_keys("degrees") || {})
    #     # ActiveSupport::JSON.encode(attributes.select_keys("value", "unit") || {})
    #   elsif value.is_a? Temperature
    #     ActiveSupport::JSON.encode(value.attributes || {})
    #   else
    #     super
    #   end
    # end

    # def restore_from(attribute)
    #   if attribute["degrees"]
    #     klass.new(attribute["degrees"])
    #   elsif attribute["value"]
    #     klass.new(attribute["value"])
    #   else
    #     klass.new
    #   end
    # end

end
