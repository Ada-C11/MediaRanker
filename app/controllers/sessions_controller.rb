class SessionsController < ApplicationController
  def login
    if user.nil?
      user = User.create(name: params[:author][:username])
    end

    user = User.find_by(name: params[:user][:username])
  end
end
