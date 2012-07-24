module ApplicationHelper

  def current_user
    User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end


end
