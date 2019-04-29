# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end

    @users_votes = Vote.where(user_id: user_id)
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username, number_of_votes: 0)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to home_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to home_path
  end

end

private

def user_params
  params.require(:user).permit(
    :username,
    :number_of_votes,
  )
end
