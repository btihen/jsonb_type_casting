# https://makandracards.com/alexander-m/43081-value-object
class Height < ValueObjectBase
  attr_reader  :height
  alias_method :height, :value

  def initialize(attribs={})
    value, unit = case attribs
                  when Hash
                    attribute = attribs.with_indifferent_access
                    value = attribute[:degrees] || attribute[:value]
                    unit  = attribute[:units]   || attribute[:unit]  || "cm"
                    [value, unit]
                  when Array
                    raise ArgumentError, "argument must be a number or a hash {degree: , unit:}"
                  else
                    [attribs, "cm"]
                  end
    cast_value = case value
                  when String
                    value.to_s.blank? ? nil : Float(value.to_f)
                  when Integer
                    Float(value)
                  when BigDecimal
                    Float(value)
                  when Float, NilClass
                    value
                  else
                    raise ArgumentError, "Degrees must be a numeric type"
                  end
    super({value: cast_value, unit: unit})
  end

  # define the unit
  def attributes
    {height: height, unit: unit}
  end

  def to_s
    return "" if unit.nil?

    "#{height} #{unit}"
  end

  private

  def get_attributes(attribs)
    case attribs
    when Hash
      attribute = attribs.with_indifferent_access
      value = attribute[:degrees]
      unit  = attribute[:unit] || "*C"
      [value, unit]
    when Array
      raise ArgumentError, "argument must be a number or a hash {degree: , unit:}"
    else
      [attribs, "*C"]
    end
  end

  def cast_value(value)
    case value
    when String
      value.to_s.blank? ? nil : Float(value.to_f)
    when Integer
      Float(value)
    when BigDecimal
      Float(value)
    when Float, NilClass
      value
    else
      raise ArgumentError, "Degrees must be a numeric type"
    end
  end

end
