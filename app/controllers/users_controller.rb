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

  def login_form
    @user = User.new
  end

  def login
    if @user.nil?
      @user = User.create(username: params[:user][:username])
      session[:user_id] = @user.id
    else
      # elsif @user.valid?
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  def current
    unless @user
      flash[:error] = 'You must be logged in to see this page'
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def vote
    @work = Work.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = 'You must log in before voting!'
      redirect_to root_path
    elsif @user.voted_for? @work
      flash[:error] = 'You can only vote for a work once!'
      redirect_to works_path
    else
      @work.upvote_by @user
      redirect_to work_path(@work.id)
    end
  end

  private

  def find_user
    session[:user_id] = nil if User.find_by(id: session[:user_id]).nil?
    @user = User.find_by(id: session[:user_id])
  end
end
