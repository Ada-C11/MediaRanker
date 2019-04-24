module ApplicationHelper
  def display_username(session_user_id)
    return "[unknown]" unless session_user_id
    user ||= User.find(session_user_id) if session_user_id
    return (user.username)
  end
end
