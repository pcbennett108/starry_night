class ConstellationsController < ApplicationController
  def index
    @constellations = Constellation.order(created_at: :DESC)
  end

  def show
    @constellation = Constellation.find(params[:id])
  end

  def new

  end

  def create
    constellation = Constellation.new(constellation_params)

    if constellation.save
      redirect_to "/constellations"
    else
      redirect_to "/constellations/new"
      #flash[:alert] = "Error: #{error_message(constellation.errors)}"
    end
  end

  def edit
    @constellation = Constellation.find(params[:id])
  end

  def update
    constellation = Constellation.find(constellation_params[:id])
    if constellation.update(constellation_params)
      redirect_to "/constellations"
    else
      redirect_to "/constellations/#{constellation.id}/edit"
      #flash[:alert] = "Error: #{error_message(constellation.errors)}"
    end
  end

  private
  def constellation_params
    params.permit(:id, :name, :symbolism, :bayer_stars, :stars_with_planets, :in_zodiac)
  end
  
end