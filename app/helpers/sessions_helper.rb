module SessionsHelper
  def login(user)
    session[:id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
    # this rescue action handles the circumstance when we delete a user before logging out (from: elaine and omar :) )
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

  def logout
    session[:id] = nil
  end
end
