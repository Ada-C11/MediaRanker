class UsersController < ApplicationController

  def index
    @users = Users.all.sort_by(&:id)
  end
  
end
