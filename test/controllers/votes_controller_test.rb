require "test_helper"

describe VotesController do
  describe "create" do
    it "creates a new vote" do
      # Arrange
      user = User.create(username: "test")
      work = Work.first
      vote_data = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }
      perform_login(user)

      #Act
      expect {
        post work_votes_path(work.id), params: vote_data
      }.must_change "work.votes.length", +1

      # before_workk_count = Work.count
      # post works_path, params: work_data
      # expect(Work.count).must_equal before_work_count + 1

      # Assert
      must_respond_with :redirect
      must_redirect_to work_path(work.id)

      work = Work.last
      expect(vote.user_id).must_equal user.id
      expect(vote.work_id).must_equal work.id
    end
    # it "sends back bad_request if no work data is sent" do
    #   work_data = {
    #     work: {
    #       title: "",
    #     },
    #   }
    #   expect(Work.new(work_data[:work])).wont_be :valid?

    #   # Act
    #   expect {
    #     post works_path, params: work_data
    #   }.wont_change "Work.count"

    #   # Assert
    #   must_respond_with :bad_request
    # end
  end
end
