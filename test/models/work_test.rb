require "test_helper"

describe Work do
  let(:vote) { votes(:vote_2) }
  let(:user) { users(:user2) }
  let(:work) { works(:one) }
  let(:work3) { works(:three) }
  
  describe "validations" do
    before do
      work_data = {
          category: "album", 
          title: "Ain't That Good News", 
          author: "Sam Cooke", 
          publication_year: 1964, 
          description: "Ain't That Good News is the thirteenth and final studio album by American R&B and soul singer-songwriter Sam Cooke, released March 1, 1964, on RCA Victor Records, in both mono and stereo, LPM 2899 and LSP 2899."    
      }
      
       @work = Work.new(work_data)   
    end
    
    it "is valid when fields are present" do
      result = @work.valid?
      
      expect(result).must_equal true
    end

    
    it "is invalid with missing author" do
      @work.author = nil
      
      result = @work.valid?
      
      expect(result).must_equal false
    end
    
    it "is invalid with missing title" do
      @work.title = nil
      
      result = @work.valid?
      
      expect(result).must_equal false
    end
    
    it "is invalid with missing category" do
      @work.category = nil
      
      result = @work.valid?
      
      expect(result).must_equal false
    end
  end
  
  describe "top ten method" do
    it "can get the top books" do
    
      top_books = Work.top_ten("book")
      
      expect(top_books.count).must_equal 2
    end
    
    it "handles ties properly" do
      works = Work.all
      
      works.each do |work|
        work.votes = 5
        
      
      end
    end
    
    it "will display a message if there are no works in that category" do
      top_books = Work.top_ten("salad")
      
      expect(top_books).must_equal "There are no salads right now. Go add some!"
    end
  end
  
  describe "relationships" do
    it "belongs to a work" do
      vote.work = work3
      expect(vote.work_id).must_equal work3.id
    end

    it "belongs to a user" do
      test_user = vote.user
      expect(vote.user_id).must_equal test_user.id
    end

    it "can set the user through the user_id" do
      new_user = User.create(name: "bebop")
      vote.user_id = new_user.id
      expect(vote.user).must_equal new_user
    end

    it "can set the work through the work_id" do
      new_work = work3
      vote.work_id = new_work.id
      expect(vote.work_id).must_equal work3.id
    end
  end
end