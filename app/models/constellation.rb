class Constellation < ApplicationRecord
  has_many :stars
end

def distance_greater_than(amount)
  stars.where("distance > #{amount.to_i}")
end

# error Private method - no method found