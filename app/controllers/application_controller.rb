class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  private

  def current_user
    @current_user ||= User.find session[:user_id] unless session[:user_id].blank?
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      session[:referrer] = request.referrer
      redirect_to login_url 
    end
  end
end
