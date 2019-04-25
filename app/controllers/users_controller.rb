class UsersController < ApplicationController
  # t.string :name
  # t.date :join_date

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :new
    end
  end

  def show
      @user = User.find(params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)
    unless user
      user = User.create(username: username)
    end
    session[:user_id] = user.id

    flash[:status] = :sucess
    flash[:message] = "Sucessfully logged in as user #{user.username}"
    redirect_to root_path #homepage
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

end
