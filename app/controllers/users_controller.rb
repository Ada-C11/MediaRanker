class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end

  def login_form
    @user = User.new
  end

  def login
  end

  def logout
  end
end
