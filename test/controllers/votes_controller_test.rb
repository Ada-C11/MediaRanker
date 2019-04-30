require "test_helper"

describe VotesController do
  let(:media) { Work.create(title: 'test work') }

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
