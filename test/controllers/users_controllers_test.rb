# frozen_string_literal: true

require 'test_helper'
require 'pry'
describe UsersController do
  let (:user) { users(:one) }

  describe 'current' do
    it 'responds with 200 ok for a logged-in user' do
      # arrange

      perform_login

      must_redirect_to works_path
      # user = User.first
      # login_data = {
      #   user: {
      #     username: user.name
      #   }
      # }
      # post login_path, params: login_data
      # expect(session[:user_id])
      #   .must_equal user.id
      # get current_user_path
      # must_respond_with :ok
    end
  end

  describe 'upvote' do
    before do
      @work = works(:favemov)
      @user = perform_login
    end
    it 'can upvote a media' do
      perform_login

      work1 = works(:favemov)

      post upvote_path(work1.id)
      expect(work1.cached_votes_total).must_equal 1
    end
  end

  describe 'index' do
    it 'can get the index path' do
      get users_path
      must_respond_with :success
    end
  end
end
