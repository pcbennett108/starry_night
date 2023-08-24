require 'rails_helper'

describe Star, type: :model do
  describe "relationships" do
    it {should belong_to(:constellation)}
  end
end