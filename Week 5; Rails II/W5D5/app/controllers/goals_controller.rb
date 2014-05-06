class GoalsController < ApplicationController

  before_action :require_signed_in!

  def index
    @goals = Goal.where(private?: false)
  end

  def new
    @goal = Goal.new
  end

  def show
    @goal ||= Goal.find(params[:id])
    @subject = @goal
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      @subject = @goal
      render :show
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    unless @goal.user_id == current_user.id
      redirect_to goals_url
      return
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      @subject = @goal
      render :show
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])

    @goal.destroy!

    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :description, :completed?, :private?)
  end

end