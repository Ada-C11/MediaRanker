require "test_helper"

describe Work do
  require "test_helper"

  describe "validations" do
    it "is valid when all fields are present" do
      result = works(:hp1).valid?

      expect(result).must_equal true
    end

    it "is invalid when title is not present" do
      invalid_work = works(:hp1)
      invalid_work.title = ""

      result = invalid_work.valid?

      expect(result).must_equal false
      expect(invalid_work.errors.messages).must_include :title
    end
  end

  # describe "relations" do
  #   it 'can set the author through "author"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")

  #     # Make the models relate to one another
  #     book.author = author

  #     # author_id should have changed accordingly
  #     expect(book.author_id).must_equal author.id
  #   end

  #   it 'can set the author through "author_id"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")

  #     # Make the models relate to one another
  #     book.author_id = author.id

  #     # author should have changed accordingly
  #     expect(book.author).must_equal author
  #   end
  # end
end
