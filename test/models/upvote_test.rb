require "test_helper"
require 'pry'

describe Upvote do

  describe "upvote composition" do 
    it "can be instantiated" do 
      new_vote = Upvote.new(user_id: users(:second_user).id, work_id: works(:movie_11).id)

      expect(new_vote.valid?).must_equal true
    end

    it "will have the required fields" do 
      vote = Upvote.first
      [:user_id, :work_id].each do |field|

        expect(vote).must_respond_to field
      end
    end

    it "for a given user validates each record has a unique work" do
    end
  end
  
  describe "relationships" do
    it "knows it's belongs to user and work" do 
      vote = Upvote.first
      
      expect(vote).must_respond_to :user
      expect(vote).must_respond_to :work
    end
  end
end
