class ConstellationsController < ApplicationController
  def index
    @constellations = Constellation.order(:created_at)
  end

  def show
    @constellation = Constellation.find(params[:id])
  end
end