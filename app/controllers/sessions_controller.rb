class SessionsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :load_authenticated_user, except: [:new]

  layout "session"

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      user.log_login
      session[:username] = user.username
      format.json { '{ data : true }' }
#     redirect_to root_url, notice: "You have successfully logged in!"
    else
#     flash.now.alert = "E-mail and/or password is invalid"
#     render 'new'
      format.json { '{ data : false }' }
    end
  end

  def destroy
    current_user.log_logout
    session[:username] = nil
    redirect_to login_path, notice: "You have been logged out"
  end

  def access_denied
    session[:username] = nil
  end
end
