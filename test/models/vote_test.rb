require "test_helper"

describe Vote do  
  describe "validations" do 
    before do
      @work = Work.create(
        title: 'test work',
        creator: 'test author',
        category: 'book',
        publication_year: 1988,
        description: 'description here'
      )
      @user = User.create(
        username: 'test user'
      )
      @vote = Vote.new(
        user_id: User.find_by(username: 'test user').id,
        work_id: Work.find_by(title: 'test work').id
      )
    end

    it "is valid when user_id and work_id is a unique combination" do 
      expect(@vote.valid?).must_equal true
    end

    it "is invalid when user_id and work_id is a non-unique combination" do 
      new_vote = Vote.new(
        user_id: Vote.first.user_id,
        work_id: Vote.first.work_id,
      )

      expect(new_vote.valid?).must_equal false 
    end
  end

  describe "relationships" do 
    before do 
      @vote = votes.first
    end

    it "belongs to a user" do 
      user = @vote.user

      expect(user).must_be_instance_of User 
    end

    it "belongs to a work" do 
      work = @vote.work

      expect(work).must_be_instance_of Work
    end
  end
end
