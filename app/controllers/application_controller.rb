class ApplicationController < ActionController::Base
  helper_method :current_user

  def log_in(user)
    cookies.permanent[:remember_digest] = user.remember_digest
    current_user = user
  end

  def current_user
    if cookies[:remember_digest]
      @current_user ||= User.find_by(remember_digest: cookies[:remember_digest])
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    cookies.delete(:remember_digest)
    current_user = nil
  end
end
