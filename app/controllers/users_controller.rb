class UsersController < ApplicationController

  def index
    @users = Users.all.sort_by(&:id)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @works = Work.where(user_id: user_id.to_i)
  end

  def edit
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    redirect_to user_path if @user.nil?
  end

  def update
    begin
      user_id = params[:id]
      user = User.find(user_id)
    rescue
      flash[:error] = "Could not find user with id: #{params['id']}"
      redirect_to user_path(user_id)
      return
    end

    if user.update(user_params)
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
    rescue
      flash[:error] = "Could not find user with id: #{params['id']}"
      redirect_to users_path
      return
    end
    user.destroy
    redirect_to users_path
  end

end

private

def user_params
  params.require(:user).permit(
    :username,
    :votes
  )
end
  