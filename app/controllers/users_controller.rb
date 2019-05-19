
class UsersController < ApplicationController
  #   before_action :find_work, except: %i[index new create]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      # user ||= User.create(user_params)
      session[:user_id] = user.id

      flash[:status] = :success
      flash[:message] = "Sucessfully logged in as user #{user.name}"
    else
      user = User.create(name: name)
      session[:user_id] = user.id
    end
    redirect_to works_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = 'You are now logged out.'
    redirect_to logout_path
  end

  def upvote
    user = User.find_by(id: session[:user_id])

    unless user
      flash[:status] = :error
      flash[:message] = "Log in to vote"
      redirect_to works_path
    else
      @work = Work.find_by(id: params[:id])
      if user.voted_for? @work
        flash[:error] = "You cannot upvote the same work twice"
        redirect_to works_path
      else
        if @work.upvote_by user
          flash[:succes] = "Successfully vote"
          redirect_to works_path
        end
      end
    end
  end
end