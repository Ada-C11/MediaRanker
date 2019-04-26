  describe Vote do
    before do
      @work = works(:rbg)
    end
    
    it "can access votes" do
      @work.id = 1
      @vote = Vote.new(work_id: 1, user_id: 2)
      expect(@work.votes).wont_be_nil
    end
    
    it "can access a user through votes" do
      expect(@work.users).wont_be_nil
    end
  end