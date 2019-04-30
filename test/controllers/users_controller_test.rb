# frozen_string_literal: true

require 'test_helper'

describe UsersController do
  let(:media) { Work.create(title: 'test work') }

  describe 'index' do
    it 'should get index' do
      get users_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'should respond with OK for an existing, valid user' do
      valid_user_id = users(:one).id

      get user_path(valid_user_id)

      must_respond_with :success
    end

    it 'should give a flash notice instead of showing a nonexistent user' do
      # user = users(:one)
      invalid_user_id = -1
      # user.destroy

      get user_path(invalid_user_id)

      expect(flash[:error]).must_equal 'Unknown user'
      must_respond_with :redirect
    end
  end

  describe 'login' do
    it 'successfully logs in a user' do
      login_as
      user = User.last
      must_respond_with :redirect

      expect(session[:user_id]).must_equal user.id
      expect(user.valid?).must_equal true
    end
  end

  describe 'vote' do
    it 'must change the votes total of the work and redirect' do
      login_as
      media = works(:album)
      post vote_path(media.id)

      must_respond_with :found
      must_respond_with :redirect

      expect(media.votes.length).must_equal 1
    end

    it 'prohibits a guest user from voting until they have logged in' do
      post vote_path(media.id)

      expect(flash[:error]).must_equal 'You must log in before voting!'
      must_respond_with :redirect
    end

    it 'prohibits a user from voting for a Work if they have already voted for it' do
      login_as
      media = works(:album)
      post vote_path(media.id)
      must_respond_with :found

      post vote_path(media.id)
      expect(flash[:error]).must_equal 'You can only vote for a work once!'
      must_respond_with :redirect
    end
  end
end
