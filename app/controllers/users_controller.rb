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
    @user = User.find_by(name: username)
    @user = User.create!(name: username) if @user.nil?
    
    if @user.id
      session[:user_id] = @user.id
      flash[:message] = "Logged in as #{@user.name}!"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end
  
  def current
    @current_user = User.find_by(id: session[user_id])
      
    if @current_user.nil?
      flash[:error] = "You must be logged in."
      
      redirect_to root_path
      return
    end
  end
  
  def logout
    user = User.find_by(id: session[:user_id])
    flash[:message] = "Successfully logged out."
    session[:user_id] = nil
    
    redirect_to root_path
  end
  
  private
  
  def user_params
    return params.require(:user).permit(:name)
  end
end
