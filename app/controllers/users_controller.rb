require "date"

class UsersController < ApplicationController
  # t.string :name
  # t.date :join_date

  def index
    @users = User.all
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     redirect_to @user, notice: "User was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to @user, notice: "User was successfully updated."
  #   else
  #     render :new
  #   end
  # end

  def show
    @user = User.find(params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]

    user = User.find_by(name: name)
    unless user
      user = User.create(user_params)
    end
    session[:user_id] = user.id

    flash[:status] = :success
    flash[:message] = "Sucessfully logged in as user #{user.name}"
    redirect_to home_path #homepage
  end

  def current
    @user = User.find_by(id: session[:user_id])

    unless @user
      flash[:status] = :error
      flash[:message] = "you must be logged in to see this page"
      redirect_to login_path
      return
    end
  end

  def logout
    session[:user_id] = nil

    flash[:status] = :success
    flash[:message] = "Sucessfully logged out"

    redirect_to root_path
  end

  def user_params
    user_params = params.require(:user).permit(
      :name,
      :join_date
    )
    unless user_params.key?(:join_date)
      user_params[:join_date] = Date.today
    end
    return user_params
  end
end
