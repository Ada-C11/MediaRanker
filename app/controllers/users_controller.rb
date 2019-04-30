# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[current logout vote show index]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = 'Unknown user'

      redirect_to users_path
    end
  end

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.email}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.email}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end

    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    redirect_to root_path
  end

  def current
    unless @user
      flash[:error] = 'You must be logged in to see this page'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out!'

    redirect_to root_path
  end

  def vote
    @work = Work.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = 'You must log in before voting!'
      redirect_to root_path
    elsif !Vote.new(user_id: @user.id, work_id: @work.id).valid?
      flash[:error] = 'You can only vote for a work once!'
      redirect_to works_path
    else
      Vote.create(user_id: @user.id, work_id: @work.id)
      flash[:success] = 'Successfully upvoted!'
      redirect_to works_path
    end
  end

  private

  def find_user
    session[:user_id] = nil if User.find_by(uid: auth_hash[:uid], provider: 'github').nil?
    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
  end
end
