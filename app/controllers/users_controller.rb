
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user 
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{username}."
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Welcome new user, #{user.username}."
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash.now[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def logout
    current_user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{current_user.username}"
    redirect_to root_path
  end

  def upvote
    current_user = User.find_by(id: session[:user_id])

    unless current_user
      flash[:status] = :error
      flash[:message] = "Must be logged in to vote!"
      redirect_to works_path
    else
      @work = Work.find_by(id: params[:id])
      if current_user.voted_for? @work
      flash[:error] = "Cannot upvote the same media twice."
      redirect_to works_path
      else
        if @work.upvote_by current_user
          flash[:success] = "Successfully voted for #{@work.title}"
          redirect_to work_path(@work.id)
        else
          flash[:error] = "There was an error with your vote."
          redirect_to work_path(@work.id)
        end
      end
    end

  end
end
