require "test_helper"

describe Work do
  let(:work) { works(:book) }
  # test custom methods, validations, relationships
  describe "work instantiation" do 
    it "can be instantiated" do 
      new_work = Work.new(category: "album", title: "new work")

      expect(new_work.valid?).must_equal true
    end

    it "will have the required fields" do 
      [:category, :title, :creator, :publication_year, :description].each do |field|

        expect(work).must_respond_to field
      end
    end
  end
  
  describe "relationships" do 
    it "knows that a work can have zero to many votes" do 
      expect(work).must_respond_to :upvotes
      expect(work.upvotes.count).must_be :>=, 0
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

    it "knows category must be book, movie, or album" do 
      work = Work.new(category: "Incorrect category", title: "Good title")
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
        all_books = Work.where(category: "book")
        all_movies = Work.where(category: "movie")
        all_albums = Work.where(category: "album")

        expect(Work.list("book").count).must_equal all_books.count
        expect(Work.list("movie").count).must_equal all_movies.count
        expect(Work.list("album").count).must_equal all_albums.count
      end
    end

    describe "top_ten_list" do
      it "shows only the top ten works by votes" do 
       all_movies = Work.top_ten_list("movie")

       expect(all_movies.count).must_equal 10
      end
    end

    describe "spotlight" do 
      it "chooses the work with the highest votes" do 
        highest_votes = Work.spotlight

        expect(highest_votes).must_be_instance_of Work
        expect(highest_votes).must_equal works(:movie)
      end

      it "will choose a work in the event of a tie" do
        Upvote.destroy_all

        first_vote = Upvote.create(user_id: users(:first_user), work_id: works(:movie))
        second_vote = Upvote.create(user_id: users(:second_user), work_id: works(:book))

        expect(Work.spotlight).must_equal works(:movie) || works(:book)

      end
      
      it "will display a random work if no votes exist" do 
        Upvote.destroy_all

        spotlight_item = Work.spotlight

        expect(spotlight_item).wont_be_nil
      end
    end
  end
end
