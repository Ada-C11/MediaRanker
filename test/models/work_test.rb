require "test_helper"

describe Work do
  let(:work) { works(:book) }
  # test custom methods, validations, relationships
  describe "relationships" do 
    it "knows that a work has votes" do 
     vote = Upvote.create!(user_id: users(:first_user).id, work_id: work.id)

      expect(work).must_respond_to :upvotes
      expect(work.upvotes.count).must_equal 1
    end
  end

  describe "validations" do 

    it "must be valid with good data" do
      good_book = works(:book)

      expect(good_book).must_be :valid?
    end

    it "validates category being present" do 
      work = Work.new(title: "The book", category: nil)

      validation = work.save

      expect(validation).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it "doesnt allow category to be empty string" do 
      work = Work.new(title: "The book", category: "")

      validation = work.save

      expect(validation).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it "validates title being present" do 
      work = Work.new(title: nil, category: "movie")
      validation = work.save

      expect(validation).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "doesn't let title be empty string" do 
      work = Work.new(title: "", category: "movie")
      validation = work.save

      expect(validation).must_equal false
      expect(work.errors.messages).must_include :title
    end
  end

  describe "custom methods" do 
    describe "list" do 
      it "lists each media by category" do 
        
      end
    end

    describe "top_ten_list" do
      it "shows only the top ten works by votes" do 
        # it won't have more than 10 works
        # it is in descending order
      end
    end

    describe "spotlight" do 
      it "chooses the work with the highest votes" do 
        
      end
    end
  end
end
