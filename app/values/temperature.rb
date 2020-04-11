class Temperature < ValueObjectBase
  # value objects are immutable after creation
  attr_reader  :degrees, :unit

  def initialize(attribs={})
    degrees, unit = get_attributes(attribs)
    @degrees      = cast_value(degrees)
    # if values aren't initialized then don't initialize unit
    @unit         = @degrees.nil? ? nil : unit
  end

  def attributes
    {degrees: degrees, unit: unit}
  end

  def to_s
    return "" if unit.blank?

    "#{degrees}#{unit}"
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
