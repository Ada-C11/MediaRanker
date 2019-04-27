require "test_helper"

describe Work do
  # let(:work) { Work.new }
  describe "validations" do
    before do
      @work = Work.new(
        title: "some unique test title",
      )
    end

    it "passes validations with good data" do
      expect(@work).must_be :valid?
    end

    it "rejects work with the same title" do
      # arrange
      duplicate_title = Work.first.title
      @work.title = duplicate_title

      # act
      result = @work.valid?

      # assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end
  
end
