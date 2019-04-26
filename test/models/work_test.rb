require "test_helper"

describe Work do
  let(:work) { works(:book1) }

  describe 'validations' do
    it 'is valid when all fields are present' do
      result = work.valid?
      expect(result).must_equal true
    end

    it 'must have a title' do
      work.title = nil
      result = work.valid?

      expect(result).must_equal false
    end
  end

  describe 'relationships' do
    it 'can have many votes' do
      votes = work.votes

      expect(votes.length).must_equal 2
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe 'vote_count' do
    let(:work2) { works(:album2) }

    it 'can calculate the number of votes' do
      num_votes = work.vote_count
      expect(num_votes).must_equal 2
    end

    it 'will return 0 for no votes' do
      num_votes = work2.vote_count
      expect(num_votes).must_equal 0
    end

  end

  describe 'top_media' do
    it 'can return the work with the most number of votes' do
      work = Work.top_media
      expect(work.title).must_equal "Nest Building"
    end

    it 'will return nil when no works are available to spotlight' do
      Work.find_by(title: "Nest Building").delete
      Work.find_by(title: "Recipes with Salt").delete
      Work.find_by(title: "Zoo Noises").delete
      Work.find_by(title: "Learn Spanish in Your Sleep II").delete

      expect(Work.top_media).must_be_nil
    end

    it 'will return first media available when no votes overall' do
      Vote.all.first.delete

      expect(Work.top_media).must_be_instance_of Work
    end

    it 'will return first media when there is a tie' do
      vote = Vote.new
      vote.user = users(:two)
      vote.work = works(:book2)

      expect(Work.top_media.title).must_equal "Nest Building"
    end
  end

  describe 'category_list' do
    before do
      @books = Work.category_list("book")
      @albums = Work.category_list("album")
    end

    it 'can display the list of works for a specific category' do
      expect(@books.first).must_be_instance_of Work
      expect(@books.first.category).must_equal "book"
      expect(@books.length).must_equal 2

      expect(@albums.first).must_be_instance_of Work
      expect(@albums.first.category).must_equal "album"
      expect(@albums.length).must_equal 2
    end

    it 'can return the list sorted by number of votes in descending order' do
      expect(@books.first.vote_count).must_equal 2
      expect(@books.last.vote_count).must_equal 1

      expect(@albums.first.vote_count).must_equal 0
      expect(@albums.last.vote_count).must_equal 0
    end

    it 'will return an empty array if there are no works in the category' do
      movies = Work.category_list("movie")
      expect(movies).must_equal []
    end
  end

  describe 'top_ten' do
    it 'will return an array of 10 elements if there are 10 or more works' do
      10.times do
        Work.create(title: "Unique Book", category: "book")
      end

      top_ten_books = Work.top_ten("book")
      expect(top_ten_books.length).must_equal 10
    end

    it 'will return an array of n elements if n is less than 10 in category' do
      top_ten_books = Work.top_ten("album")
      expect(top_ten_books.length).must_equal 2
    end

    it 'will return 0 if there are no works in the category' do
      top_ten_books = Work.top_ten("movie")
      expect(top_ten_books.length).must_equal 0
    end
  end
end