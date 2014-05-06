class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
    user_params[:username],
    user_params[:password])

    if @user
      sign_in(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    sign_out
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
