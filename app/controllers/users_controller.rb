class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    # @user = User.find_by(username: username)

    if @user.nil?
      flash[:error] = "That user does not exist"
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
      flash[:success] = "Successfully logged in as existing user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])

    unless @current_user
      flash[:error] = "You must be logged in to see this page!"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  # def upvote
  #   current_work = Work.find_by(id: params[:id])

  #   if session[:user_id]
  #     vote = Vote.new(user_id: session[:user_id], work_id: current_work.id)

  #     if vote.save
  #       flash[:success] = "Successfully upvoted!"
  #     else
  #       flash[:error] = "Could not upvote..."
  #     end
  #   else
  #     flash[:error] = "You must log in to do that"
  #     # send a flash error message saying they cannot vote unless signed in

  #   end

  #   redirect_back #fallback_location: works_url
  # end
end
