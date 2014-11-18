class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  	User.create!(params[:user])
#    user = User.new
#    user_params = params[:user]
#
#    if user.save
#      redirect_to login_url
#    else
#      redirect_to register_url
#    end
	redirect_to login_url
  end
end
