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
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    else
      @user = User.new(user_param)
      if @user.save
        flash[:success] = "Successfully created new user #{@user.username} new with ID #{@user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        @user.errors.messages.each do |label, message|
          flash.now[label.to_sym] = message
        end
        render :login_form, status: :bad_request
      end
    end
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def user_param
    params.require(:user).permit(:username)
  end
end
