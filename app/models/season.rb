class Season < ApplicationRecord
  attribute :name,        :string
  attribute :temperature, TemperatureJsonbType.new
end
