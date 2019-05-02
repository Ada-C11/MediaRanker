class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "Could not find user."
      redirect_to root_path
    else
      flash[:success] = "You are logged in."
    end
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
    redirect_to current_user_path
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    user = User.create(username: username) if user.nil?

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end

  def upvote
    @work = Work.find_by(id params[id])
    @user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "You must be logged in to vote!"
      redirect_to login_path
    end

    user_votes = @user.votes
    voting = user_votes.where(work_id: @work.id).present?

    if voting
      flash[:error] = "Can't vot for the same work twice :("
      redirect_to works_path
    else
      @user_votes.create!(work_id: @work.id)
    end
  end
end
