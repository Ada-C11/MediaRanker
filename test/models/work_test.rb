require "test_helper"

describe Work do
  # let(:work) { Work.new }
  before do
    @work = Work.new(
      title: "some unique test title",
    )
  end
  describe "validations" do
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
  describe "relations" do
    it "has votes" do
      work = Work.create!(title: "test")
      user = User.create!(username: "test")
      Vote.create!(work_id: work.id, user_id: user.id)
      # Vote.create(work_id: @work.id, user_id: 4)

      expect(@work.votes.length).must_equal 1
      expect(vote.work_id).must_equal @work.id
    end
  end

  describe "spotligth" do
  end
  describe "top ten movies" do
  end
  describe "top ten books" do
  end
  describe "top ten album" do
  end
end
