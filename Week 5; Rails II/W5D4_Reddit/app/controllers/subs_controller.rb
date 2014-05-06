class SubsController < ApplicationController

  before_action :require_signed_in!

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @links = @sub.links
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.mod_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    if current_user.id == @sub.mod_id
      render :edit
    else
      flash.now[:errors] = ["You're not qualified to edit!"]
      render :show
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])

    if current_user.id == @sub.mod_id
      @sub.destroy!
      redirect_to subs_url
    else
      flash.now[:errors] = ["You're not qualified to delete!"]
      render :show
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:name, :mod_id)
  end

end
