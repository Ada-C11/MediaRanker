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

  describe 'custom methods' do
    it 'sorts media by number of votes' do
      Vote.all = {
        one: {
          id: 2,
          work_id: 980190986,
          user_id: 1,
        },

        two: {
          id: 3,
          work_id: 980190988,
          user_id: 1,
        },

        three: {
          id: 4,
          work_id: 980190988,
          user_id: 1,
        }
      }

      expect(Work.sort_media('movie')).first.work_id must_equal 980190988

    end
  end
end
