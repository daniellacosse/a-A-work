class TracksController < ApplicationController
  def index
    render :index
  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  def new
    @track = Track.new

    render :new
  end

  def create
    @track = Track.new(track_params)
    @album = Album.find(@track.album_id)

    if @track.save
      redirect_to album_url(@album)
    else
      fail
      flash[:alert] = ["Something's wrong! Track not created."]

      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])

    render :edit
  end

  def update

  end

  def destroy
    Track.destroy(params[:id])
  end

  private
  def track_params
    params.require(:track).permit(:title, :lyrics, :bonus, :album_id)
  end
end
