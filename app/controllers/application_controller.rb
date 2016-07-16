class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :another_user, :require_login
  before_action :require_login

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def another_user
    @another_user ||= User.where.not id: current_user
  end

  def signed_in?
    !!current_user
  end

  def require_login
    unless signed_in?
      flash[:error] = 'You must be logged in to access!'
      redirect_to login_path
    end
  end
end
