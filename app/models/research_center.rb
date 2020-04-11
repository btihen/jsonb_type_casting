class ResearchCenter < ApplicationRecord
  belongs_to :address
  has_many   :scientists
end
