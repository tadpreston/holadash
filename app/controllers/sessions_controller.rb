class SessionsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :load_authenticated_user, except: [:new]

  layout 'sessions'

  def new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      @user.log_login(@user.full_name, "Logged in successfully.")
      cookies[:auth_token] = @user.auth_token
    end
  end

  def destroy
    current_user.log_logout(current_user.full_name, "Logged out.")
    cookies.delete(:auth_token)
    redirect_to login_path, notice: 'You have been logged out!'
  end

  def access_denied
    cookies.delete(:auth_token)
  end
end
