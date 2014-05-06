class UsersController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    if params[:user][:password] == params[:user][:conf_password]

      @user = User.new(user_params)

      if @user.save
        log_in(@user)

        redirect_to bands_url
        return
      else
        flash[:alert] = ["YOU BLEW IT"]

        render :new
        return
      end
    else
      flash[:alert] = ["Password/Confirm Password mismatch"]

      render :new
      return
    end
  end

  def show
    unless current_user
      redirect_to new_session_url
      return
    end

    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
