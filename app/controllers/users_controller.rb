class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create

    user.email = params[:email]

    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]

    if user.save
      redirect_to events_url
    else
      redirect_to events_url
    end
  end
end
