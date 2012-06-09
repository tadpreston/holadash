class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :load_authenticated_user
  helper_method :authenticate

  protect_from_forgery

  before_filter :load_authenticated_user, except: :access_denied
  before_filter :authenticate, except: :access_denied

  private

  def current_user
    @current_user ||= User.find_by_username(session[:username]) unless session[:username].blank?
  end

  def permission_denied
    flash[:alert] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end

  def load_authenticated_user
    unless session[:username].blank?
      if current_user.nil?
        redirect_to access_denied_path
      else
        Authorization.current_user = current_user
      end
    end
  end

  def authenticate
    unless current_user
      session[:referrer] = request.referrer
      redirect_to login_url 
    end
  end
end
