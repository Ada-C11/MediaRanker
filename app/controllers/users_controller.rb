def current
  @user = User.find_by(id: session[:user_id])
  if @user.nil?
    flash[:error] = "You must be logged in first!"
    redirect_to root_path
  end
end

def logout
  user = User.find_by(id: session[:user_id])
  session[:user_id] = nil
  flash[:notice] = "Logged out #{user.username}"
  redirect_to root_path
end
