class ApplicationController < ActionController::Base


  helper_method :require_login, :logged_in?, :current_user

  def require_login

  end

  def logged_in?
     current_user != nil
  end

  def current_user
    if session[:user_id]
     @user ||= User.find(session[:user_id])
   end
  end

end
