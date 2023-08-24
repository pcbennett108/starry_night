class ConstellationsController < ApplicationController
  def index
    @cons = Constellation.all
  end
end