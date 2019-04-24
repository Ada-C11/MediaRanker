class SessionsController < ApplicationController
  def login
    @user = User.find_by(username: params[:user][:username])

    if @user.nil?
      @user= User.create(username: params[:user][:username], date_joined: DateTime.now)
      if @user.save
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
        redirect_to root_path
      else
        flash.now[:warning] = "A problem occurred: Could not log in"

        @user.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :new
      end
    else
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
      redirect_to root_path
    end
    session[:user_id] = @user.id
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back fallback_location: root_path
  end
end