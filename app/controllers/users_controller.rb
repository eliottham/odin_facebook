class UsersController < ApplicationController
 
  def show
  	@user = User.find(params[:id])
  	@post = current_user.posts.build if current_user == @user
  end

  def index
  	@users = User.all
  end
end
