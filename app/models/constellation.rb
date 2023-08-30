class Constellation < ApplicationRecord
  has_many :stars
  # has_many :patients, dependent: :destroy
  # Allows automatic deletion of childern when parent deleted.
end

def distance_greater_than(amount)
  stars.where("distance > #{amount.to_i}")
end

# error Private method - no method found