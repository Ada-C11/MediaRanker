require "test_helper"

describe Work do
  let(:work) { works(:one) }

  it "must be valid" do
    work = works(:one)

    valid_work = work.valid?

    expect(valid_work).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      # Arrange
      work.title = nil

      # Act
      valid_work = work.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end
end
