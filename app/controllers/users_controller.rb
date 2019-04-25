class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    is_successful = user.save

    if is_successful
      redirect_to user_path(user.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path
    end
  end

  def update
    user = User.find_by(id: params[:id])

    if user.nil?
      redirect_to users_path
    else
      is_successful = user.update(user_params)
    end

    if is_successful
      redirect_to user_path(user.id)
    else
      @user = user
      render :edit, status: :bad_request
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user.nil?
      head :not_found
    else
      user.trips.each do |trip|
        trip.destroy
      end
      user.destroy
      redirect_to users_path
    end
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
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
