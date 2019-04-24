require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(
        title: "A Great Book"
      )
    end

    it "passes validations with good data" do
      expect(@work).must_be :valid?
    end

    it "rejects work with repeated title" do
      duplicate_title = Work.first.title
      @work.title = duplicate_title

      result = @work.valid?

      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end
end
