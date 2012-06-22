class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :load_authenticated_user, except: [:new]

  layout 'sessions'

  def new
  end

  def create
    user = User.find_by_email(params[:mail])
    user.send_password_reset if user
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      @reset_status = 'expired'
#     redirect_to new_password_reset_path, alert: "Password reset has expired"
    elsif @user.update_attributes(params[:user])
      @reset_status = 'success'
#     redirect_to root_url, notice: "Password has been reset!"
    else
      @reset_status = 'error'
#     render :edit
    end
  end
end
