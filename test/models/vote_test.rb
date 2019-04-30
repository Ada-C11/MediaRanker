require "test_helper"

describe Vote do

  describe "validations" do 
    it "is valid" do
      user = User.new(name: 'jane')
      work = Work.new(title: 'Imagine Dragons', category: "album")
      @vote = Vote.new(user: user, work: work)
      
      valid_vote = @vote.valid?
    end

    it "must have a user id and a work_id" do
      vote = Vote.new
      user = User.new(name: "jane")
      work = Work.new(title: "Imagine Dragons")
      
      vote.wont_be :valid?
      vote.errors.messages.must_include :user
      vote.errors.messages.must_include :work
    end

    it "same user's vote on same thing won't save" do
      user = User.new(name: 'jane')
      work = Work.new(title: 'Imagine Dragons', category: "album")
      @vote = Vote.new(user: user, work: work)
      
      @vote.save
      @vote.wont_be :valid? 
    end
  end

  describe "relationships" do
    it "has a user" do
      user = User.new(name: 'jane')
      work = Work.new(title: 'Imagine Dragons', category: "album")
      @vote = Vote.new(user: user, work: work)

      @vote.must_respond_to :user
      @vote.user.must_equal user
      @vote.user_id.must_equal user.id
    end

    it "has a work" do
      user = User.new(name: 'jane')
      work = Work.new(title: 'Imagine Dragons', category: "album")
      @vote = Vote.new(user: user, work: work)

      @vote.must_respond_to :work
      @vote.work.must_equal work
      @vote.work_id.must_equal work.id
    end
  end


end




