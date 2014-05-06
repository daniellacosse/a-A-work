class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user
      log_in(@user)

      redirect_to bands_url
    else
      flash[:alert] = ["User doesn't exist. Do you want to sign up?"]

      render :new
    end
  end

  def destroy
    log_out

    render :new
  end

end
