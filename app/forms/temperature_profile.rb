class TemperatureProfile < FormObjectBase
  attribute :below_ground_temperature, TemperatureType.new
  attribute :ground_level_temperature, TemperatureType.new
  attribute :one_meter_temperature,    TemperatureType.new
  attribute :two_meters_temperature,   TemperatureType.new

  # validate: all present

  def initialize(attributes={})
    @profile = [{Height.new({height:  -5, unit: "cm"}) => temperature: below_ground_temperature},
                {Height.new({height:   0, unit: "cm"}) => temperature: below_ground_temperature},
                {Height.new({height: 100, unit: "cm"}) => temperature: below_ground_temperature},
                {Height.new({height: 200, unit: "cm"}) => temperature: below_ground_temperature}]
  end

end
