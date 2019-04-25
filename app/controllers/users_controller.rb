class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      flash[:error] = "Unknown user"
      redirect_to users_path
    end
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new( user_params )

  #   save_is_successful = @user.save

  #   if save_is_successful
  #     flash[:success] = "Successfully added User to database"
  #     redirect_to user_path(@user.id)
  #   else
  #     @user.error.messages.each do |field, messages|
  #       flash.now[field] = messages
  #     end
  #     render :new, status: :bad_request
  #   end
  # end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:name]
    user = User.find_by(name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id]).name
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.name}"
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
