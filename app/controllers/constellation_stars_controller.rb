class ConstellationStarsController < ApplicationController
  def index
    @constellation = Constellation.find(params[:const_id])
    @stars = @constellation.stars
  end
end