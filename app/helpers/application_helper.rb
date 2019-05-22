module ApplicationHelper
  def display_name(id)
    name = User.find_by(id: session[:user_id]).username
    return name
  end
end
