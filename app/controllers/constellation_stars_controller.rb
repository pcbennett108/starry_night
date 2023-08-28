class ConstellationStarsController < ApplicationController
  def index
    @constellation = Constellation.find(params[:const_id])
    @stars = @constellation.stars
  end
  
  def new
    @constellation = Constellation.find(params[:const_id])
  end

  def create
    constellation = Constellation.find(params[:const_id])
    star = constellation.stars.create(star_params)
    redirect_to "/constellations/#{star.constellation_id}/stars"
  end

  private

  def star_params
    params.permit(:name, :distance, :mass, :radius, :visible)
  end
end