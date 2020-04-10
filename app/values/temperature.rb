# https://makandracards.com/alexander-m/43081-value-object
class Temperature < ValueObject

  attr_reader  :degrees
  alias_method :degrees, :value


  def initialize(attribs={})
    value = case attribs
            when Hash
              attribute = attribs.with_indifferent_access
              attribute[:degrees] || attribute[:value]
            when String
              attribs.to_s.blank? ? nil : Float(attribs.to_s)
            when Integer
              Float(attribs)
            when Float
              attribs
            when NilClass
              nil
            else
              raise ArgumentError
            end
    unit = case attribs
            when Hash
              attribute = attribs.with_indifferent_access
              attribute[:unit] || attribute[:units] || "*C"
            else
              "*C"
            end
    super({value: value, unit: unit})
  end

  # define the unit
  def attributes
    super.attributes.merge({degrees: degrees})
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
