class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if !@user
      flash[:failure] = "User Not Found."
      redirect_to root_path
    end
  end
end
