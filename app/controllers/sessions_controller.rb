class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:error] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
