class UsersController < ApplicationController
    before_action :find_work, except: %i[index new create]

    def login_form
        @user = User.new
        end
    
      def login
        username = params[:user][:username]
        user = User.find_by(username: username)
        flash_msg = if user.nil?
                      'Welcome new user!'
                    else
                      "Welcome back #{username}!"
                    end
        user ||= User.create(username: username)
        session[:user_id] = user.user_id
        flash[:success] = "#{username} is logged in."
        redirect_to root_path
      end
    
      def current
        @user = User.find_by(id: session[:user_id])
      end
    end