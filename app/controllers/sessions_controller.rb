class SessionsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :load_authenticated_user, except: [:new]
  protect_from_forgery :except => [:create]

  layout false

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      user.log_login(user.full_name, "Logged in successfully.")
      cookies[:auth_token] = user.auth_token
    end
  end

  def destroy
    current_user.log_logout(current_user.full_name, "Logged out.")
    session[:username] = nil
    redirect_to login_path, notice: "You have been logged out"
  end

  def access_denied
    session[:username] = nil
  end
end
