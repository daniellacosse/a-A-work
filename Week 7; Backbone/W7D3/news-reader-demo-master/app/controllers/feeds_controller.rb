class FeedsController < ApplicationController
  def index
    @feeds = Feed.includes(:entries).all

    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @feeds.as_json(include: :entries) }
    end
  end

  def create
    feed = Feed.find_or_create_by_url(feed_params[:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feed.reload
    render json: @feed
  end

  private
  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
