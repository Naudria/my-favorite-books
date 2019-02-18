class ApplicationController < ActionController::Base
  before_action :current_user


  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    session[:user_id]
  end

  def redirect_if_not_logged_in
    if !logged_in?
      redirect_to root_path
    end
  end

end
