class StarsController < ApplicationController
  def index
    @stars = Star.all
  end

  def show
    @star = Star.find(params[:id])
  end

  def edit
    @star = Star.find(params[:id])
  end

  def update
    star = Star.find(star_params[:id])
    if star.update(star_params)
      redirect_to "/stars"
    else
      redirect_to "/star/#{star.id}/edit"
      #flash[:alert] = "Error: #{error_message(constellation.errors)}"
    end
  end

  private

  def star_params
    params.permit(:id, :name, :distance, :mass, :radius, :visible)
  end
end