# https://makandracards.com/alexander-m/43081-value-object
class Temperature < ValueObject

  attr_reader  :degrees
  alias_method :degrees, :value


  def initialize(attribs={})
    value, unit = case attribs
                  when Hash
                    attribute = attribs.with_indifferent_access
                    value = attribute[:degrees] || attribute[:value]
                    unit  = attribute[:units]   || attribute[:unit]  || "*C"
                    [value, unit]
                  when Array
                    raise ArgumentError, "argument must be a number or a hash {degree: , unit:}"
                  else
                    [attribs, "*C"]
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
    ({degrees: degrees}).merge(super).except(:value)
  end

  # value object logic
  def hot?
    self >= HOT_THRESHOLD
  end

  def cool?
    self <= COOL_THRESHOLD
  end

  def cold?
    self <= COLD_THRESHOLD
  end

  protected
  HOT_THRESHOLD  = new(25)
  COOL_THRESHOLD = new(15)
  COLD_THRESHOLD = new(5)

end
