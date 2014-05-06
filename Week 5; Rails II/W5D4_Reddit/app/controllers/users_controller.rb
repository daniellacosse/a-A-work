class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    match = (user_params[:password] == params[:user][:password_confirm])
    if match && @user.save
      sign_in(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      flash.now[:errors] << "Password Mismatch!" unless match
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
