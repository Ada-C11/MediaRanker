class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.joined = Date.today

    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
