require "test_helper"

describe User do
  let(:user) { users(:user1) }
  let(:vote) { votes(:two) }
  let(:vote2) { votes(:one) }

  describe "validations" do
    it "must be valid" do
      value(user).must_be :valid?
    end
    it "requires a name" do
      user.name = nil
      expect(user.save).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "requires a unique name" do
      duplicate_user = User.new(name: "Mollie")
      expect(duplicate_user.save).must_equal false
      expect(duplicate_user.errors.messages).must_include :name
      expect(duplicate_user.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end

  # describe "relationships" do
  #   it "has many votes" do
  #     new_genre = genres(:one)
  #     book.genres << new_genre
  #     expect(new_genre.books).must_include book
  #   end

  #   it "can have 0 votes" do
  #     genres = book.genres
  #     expect(genres.length).must_equal 0
  #   end

  #   it "can set the vote through the vote_id" do
  #     new_author = Author.create(name: "new author")
  #     book.author_id = new_author.id
  #     expect(book.author).must_equal new_author
  #   end
  # end
end
