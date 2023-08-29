class StarsController < ApplicationController
  def index
    if params[:visible]
      @stars = Star.where(:visible => params[:visible])
    else
      @stars = Star.all
    end
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

  def destroy
    star = Star.find(params[:id])
    star.delete

    redirect_to "/stars"
  end

  private

  def star_params
    params.permit(:id, :name, :distance, :mass, :radius, :visible)
  end
end