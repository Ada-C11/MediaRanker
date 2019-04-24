class UsersController < ApplicationController
  
  def index
    @users = User.all 
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    
    unless @user
      redirect_back(fallback_location: users_path)
      flash[:error] = "That user cannot be found or no longer exists."
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    @user.save
    
    unless @user
      render :new
      flash[:error] = "Account can't be created at this time."
    else
      flash[:success] = "Welcome to the Media Ranker community, #{@user.name}! Take a look around, and start contributing by adding new works and upvoting existing ones."
      
      redirect_to root_path
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:name]
    @user = User.find_by(username: username)
    
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.name}!"
      redirect_back(fallback_location: root_path)
    else
      @user = User.create!(name: username)
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Media Ranker community, #{@user.name}!"
    end
    
    redirect_back(fallback_location: root_path)
  end
  
  def current
    @current_user = User.find_by(id: session[user_id])
      
    unless @current_user
      redirect_to login_path
      flash[:error] = "Could not find user. Try logging in again."
    end
  end
  
  def logout
    @user = User.find_by(id: params[:id])
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    
    redirect_to root_path
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:name)
  end
end
