require "test_helper"

describe Work do
  let(:album1) { works(:album1) }
  let(:user) { users(:one) }
  let(:vote1) { votes(:vote1) }
  let(:vote2) { votes(:vote2) }

  it "must be valid" do
    value(album1).must_be :valid?
  end

  describe "topten" do
    it "will return top votes" do
    end
  end

  describe "validations" do
    it "requires a title" do
      # Arrange
      album1.title = nil

      # Act
      valid_work = album1.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(album1.errors.messages).must_include :title
      expect(album1.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end
end
