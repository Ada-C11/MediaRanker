# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.sort_by(&:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @works = Work.where(user_id: user_id.to_i)
  end

  def edit
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    redirect_to user_path if @user.nil?
  end

  def update
    begin
      user_id = params[:id]
      user = User.find(user_id)
    rescue StandardError
      flash[:error] = "Could not find user with id: #{params['id']}"
      redirect_to user_path(user_id)
      return
    end

    if user.update(user_params)
      redirect_to users_path
    else
      render :new
    end
    
  end

  def destroy
    begin
      user = User.find(params[:id])
    rescue StandardError
      flash[:error] = "Could not find user with id: #{params['id']}"
      redirect_to users_path
      return
    end
    user.destroy
    redirect_to users_path
  end

  # def login_form
  #   @user = User.new
  # end

  # def login
  #   username = params[:user][:username]
  #   user = User.find_by(username: username)

  #   if user
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as returning user #{username}"
  #   else
  #     user = User.create(username: username) # may want to have validation that user.create worked
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as new user #{username}"
  #   end

  #   redirect_to home_path
  # end

  # def current
  #   @current_user = User.find_by(id: session[:user_id])
  #   unless @current_user
  #     flash[:error] = 'You must be logged in to see this page'
  #     redirect_to login_path
  #     return
  #   end
  # end

  # def logout
  #     session[:user_id] = nil
  #     flash[:success] = "You have successfully logged out"
  #     redirect_to home_path
  # end
end

private

def user_params
  params.require(:user).permit(
    :username,
    :votes
  )
end
