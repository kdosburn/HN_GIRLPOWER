class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :random_post, :render_404

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def render_404
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end


end
