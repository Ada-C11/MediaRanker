require "test_helper"

describe Work do
  let(:work) { works(:two) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it "has required fields" do
    fields = [:category, :title, :creator, :publication_year, :description, :votes]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "has many votes" do
      work.votes << Vote.new
      votes = work.votes

      expect(work).must_be_instance_of Work
      expect(work.votes).must_be_instance_of Array
      expect(votes.length).must_be 1
      expect(votes.first).must_be_instance_of Vote
    end
  end

  describe "validations" do
    it "must have a category" do
      work.category = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]

      work.category = "book"
      valid = work.valid?
      expect(valid).must_equal true
    end

    it "must have a title" do
      work.title = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]

      work.title = "Sabriel"
      valid = work.valid?
      expect(valid).must_equal true
    end
  end

  describe "spotlight" do
    it "should return a work object" do
      # Arrange & Act
      work = Work.spotlight

      # Assert
      expect(work).must_be_instance_of Work
    end

    it "should have the most votes of all work objects" do
      # Arrange
      10.times do
        Work.first.votes << Vote.new
      end

      # Act
      top_work = Work.spotlight
      vote_count = top_work.votes.length

      # Assert
      expect(vote_count).must_equal Work.all.max_by { |work| work.votes.length }.votes.length
    end

    # TODO: tiebreakers
    # it 'should return the one thats first alphabetically if theres a tie' do
    # end

    # TODO: Need to account for this in the view
    it "should return nil if there are no works" do
      # Arrange
      Work.all.each do |work|
        work.destroy
      end

      # Act
      top_work = Work.spotlight

      # Assert
      expect(top_work).must_be_nil
    end
  end

  describe "albums" do
    it "returns array of only albums" do
      albums = Work.albums

      expect(albums).must_be_instance_of Array

      albums.each do |album|
        expect(album).must_be_instance_of Work
        expect(album.category).must_equal "album"
      end
    end

    it "returns empty array if no albums exist" do
      Work.all.each do |work|
        if work.category == "album"
          work.destroy
        end
      end

      albums = Work.albums

      expect(albumss).must_be_instance_of Array
      expect(albums.length).must_equal 0
    end
  end
end
