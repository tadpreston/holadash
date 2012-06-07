class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "You have successfully logged in!"
    else
      flash.now.alert = "E-mail and/or password is invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You have been logged out"
  end
end
