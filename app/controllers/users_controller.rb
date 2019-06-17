class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)

    if @user.nil?
      flash.now[:error] = "User not found."
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
