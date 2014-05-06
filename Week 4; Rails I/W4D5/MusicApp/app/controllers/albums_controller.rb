class AlbumsController < ApplicationController
  def index
    render :index
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def new
    @album = Album.new

    render :new
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find(@album.band_id)

    if @album.save
      redirect_to band_url(@band)
    else
      flash[:alert] = ["Something's wrong! Album not created."]

      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])

    render :edit
  end

  def update

  end

  def destroy
    Album.destroy(params[:id])
  end

  private
  def album_params
    params.require(:album).permit(:title, :recording, :band_id)
  end
end
