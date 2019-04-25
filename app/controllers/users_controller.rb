class UsersController < ApplicationController
  
  def login_form
    @user = User.new
  end

  def login
    user_name = params[:user][:username]
    @user = User.find_by(username: user_name)

    @user ||= User.create(username: user_name)
    
    if @user
      flash[:status] = :success
      flash[:message] = "Hello #{@user.username} you are successfully logged in"
      session[:user_id] = @user.id
    else
      flash.now[:status] = :error
      flash.now[:message] = "Please try again"
      render :login_form, status: :bad_request
    end

    redirect_to root_path
  end

  def show
    @user = User.find_by(id: session[:user_id])

    unless @user
      head :not_found
      return
    end
  end
end
