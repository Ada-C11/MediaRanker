class UsersController < ApplicationController
  before_action :find_indv_user, only: [:show, :edit, :update, :destroy]

  #   def login_form
  #     @user = User.new
  #   end

  #   def login
  #     username = params[:user][:username]
  #     user = User.find_by(username: username)
  #     user = User.create(username: username) if user.nil?

  #     if user.id
  #       session[:user_id] = user.id
  #       flash[:alert] = "#{user.username} logged in"
  #       redirect_to root_path
  #     else
  #       flash[:error] = "Unable to log in"
  #       redirect_to root_path
  #     end
  #   end

  #   def current
  #     @user = User.find_by(id: session[:user_id])
  #     if @user.nil?
  #       flash[:error] = "You must be logged in first!"
  #       redirect_to root_path
  #     end
  #   end

  #   def logout
  #     user = User.find_by(id: session[:user_id])
  #     session[:user_id] = nil
  #     flash[:notice] = "Logged out #{user.username}"
  #     redirect_to root_path
  #   end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    new_user = User.new[:user_params]

    is_successful = new_user.save

    if is_successful
      flash[:success] = "Successfully created new user #{params[:username]} with ID #{params[:id]}"

      # NEED TO MAKE HOME PAGE FOR ROOT PATH!!!
      redirect_to root_path
    else
      user.errors.messages.each do |field, message|
        flash.now[field] = message
      end
      render :new, status: :bad_request
    end
  end

  def show
    # The live app gives a 404. I wanted to give a helpful flash message and redirect instead for a better user experience.

    # find_indv_user
    if !@user
      flash[:error] = "User not found"
      redirect_to users_path
    end
  end

  private

  def find_indv_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
