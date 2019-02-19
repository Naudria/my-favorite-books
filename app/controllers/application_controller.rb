class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user.id != nil
  end

  def require_logged_in
    return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
  end
end
