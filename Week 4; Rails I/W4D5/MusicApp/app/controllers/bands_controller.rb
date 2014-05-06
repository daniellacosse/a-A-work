class BandsController < ApplicationController

  def index
    render :index
  end

  def show
    @band = Band.find(params[:id])

    render :show
  end

  def new
    @band = Band.new

    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      render :index
    else
      flash[:alert] = ["Something's wrong! Band not created."]

      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])

    render :edit
  end

  def update

  end

  def destroy
    Band.destroy(params[:id])
  end

  private
  def band_params
    params.require(:band).permit(:band_name)
  end
end
