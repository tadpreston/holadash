class SessionsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :load_authenticated_user, except: [:new]

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      user.log_login(user.full_name)
      session[:username] = user.username
      redirect_to root_url, notice: "You have successfully logged in!"
    else
      flash.now.alert = "E-mail and/or password is invalid"
      render 'new'
    end
  end

  def destroy
    current_user.log_logout(current_user.full_name)
    session[:username] = nil
    redirect_to login_path, notice: "You have been logged out"
  end

  def access_denied
    session[:username] = nil
  end
end
