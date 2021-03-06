class SessionsController < ApplicationController
  def new
    redirect_to posts_path if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to posts_path
    else
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
    end
  end

  def delete
    sign_out
    redirect_to posts_path
  end
end
