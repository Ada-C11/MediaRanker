class UsersController < ApplicationController
  
  def index
    @users = User.all 
  end

  def show
    user_id = params[:id]
  end

  def new
  end

  def create
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:name,)
  end
end
