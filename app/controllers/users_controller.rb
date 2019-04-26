class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    user = User.create(username: username) if user.nil?

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in!"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in!"
      redirect_to root_path
    end
  end

  def upvote
    user_id = session[:user_id]
    work_id = params[:id]
    date = Date.today
    vote = Vote.new(date: date, user_id: user_id, work_id: work_id)

    if vote.save
      flash[:success] = "Work has been voted!"
    else
      vote.errors.messages.each do |field, messeges|
        flash.now[field] = messages
      end
    end
    redirect_to work_path(work_id)
  end

  #   def current
  #     @user = User.find_by(id: session[:user_id])
  #     if @user.nil?
  #       flash[:error] = "You must be logged in first!"
  #       redirect_to root_path
  #     end
  #   end
end
