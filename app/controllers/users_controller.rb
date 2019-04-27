class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def login_form
  end

  def login
  end

  def logout
  end
end
