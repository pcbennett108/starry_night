require 'rails_helper'

describe Constellation, type: :model do
  describe "validations" do
    it {should have_many(:stars)}
  end
end