class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
    if @user = User.find_by(email: params[:email]) and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = 'Signed in'
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out.'
    redirect_to root_path
  end
end
