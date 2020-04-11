# https://makandracards.com/alexander-m/43081-value-object
class Location < ValueObjectBase

  attr_reader  :longitude, :latitude, :unit

  def initialize(attribs={})
    longitude, latitude, unit = get_attributes(attribs)
    @longitude = cast_value(longitude)
    @latitude  = cast_value(latitude)
    @unit      = (long_cast.nil? && lat_cat.nil?) ? nil : unit
  end

  def attributes
    {longitude: longitude, latitude:  latitude, unit: unit}
  end

  # override as needed
  def to_s
    return "" if unit.blank?

    "longitude: #{longitude}#{unit}, latitude: #{latitude}#{unit}"
  end

  private

  def get_attributes(attribs)
    case attribs
    when Hash
      attribute = attribs.with_indifferent_access
      long = attribute[:longitude]
      lat  = attribute[:latitude]
      unit = attribute[:unit] || "*"
      [long, lat, unit]
    else
      raise ArgumentError, "argument must be a number or a hash {degree: , unit:}"
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
