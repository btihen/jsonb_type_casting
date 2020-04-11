class Address < ApplicationRecord
  has_many :scientists
  has_many :research_centers
end
