class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
    if @user.nil?
      render :not_found, status: :not_found
    end
  end
end
