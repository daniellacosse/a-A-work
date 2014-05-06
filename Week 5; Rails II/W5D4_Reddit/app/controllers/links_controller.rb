class LinksController < ApplicationController

  def index

  end

  def new
    @link = Link.new
    render :new
  end

  def show
    @link = Link.find(params[:id])
    render :show
  end

  def create
    @link = Link.new(link_params)
    @link.poster_id = current_user.id
    @link.sub_ids = params[:link][:sub_ids]
    if @link.save
      render :show
    else
      flash.now[:errors] = ["Invalid Link Inputs"]
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])


  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :body, :sub_ids)
  end

end
