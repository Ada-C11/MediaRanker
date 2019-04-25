require "test_helper"
require "pry"

# For top-10 or spotlight, what if there are less than 10 works?
# What if there are no works?

describe Work do
  let(:work) { Work.first }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "validation" do
    it "has valid data" do
      expect(work).must_be :valid?
    end

    it "requires a present title" do
      invalid_work = Work.new
      invalid_work.save
      error_message = invalid_work.errors.messages[:title][0]
      expect(invalid_work.valid?).must_equal false
      expect(error_message).must_equal "can't be blank"
    end

    it "rejects a duplicate title" do
      title = work.title
      invalid_work = Work.new(title: title)
      invalid_work.save
      error_message = invalid_work.errors.messages[:title][0]
      expect(invalid_work.valid?).must_equal false
      expect(error_message).must_equal "has already been taken"
    end
  end

  describe "custom methods" do
    describe "spotlight" do
      it "displays a spotlighted work" do
        spotlight_work = Work.spotlight
        expect(spotlight_work).must_be_instance_of Work
      end

      it "returns nil for no works" do
        Work.destroy_all
        expect(Work.spotlight).must_equal nil
      end
    end

    describe "top ten" do
    end
  end
end
