require "test_helper"
require "pry"

# For top-10 or spotlight, what if there are less than 10 works?
# What if there are no works?

describe Work do
  let(:work) { Work.first }

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

    it "responds to votes" do
      assert_respond_to(work, :votes)
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
      it "returns top rated work" do
        Vote.destroy_all
        perform_vote(work, User.first)
        spotlight_work = Work.spotlight
        expect(spotlight_work).must_be_instance_of Work
        expect(spotlight_work).must_equal work
      end

      it "returns nil for no works" do
        Work.destroy_all
        expect(Work.spotlight).must_equal nil
      end

      it "selects the first item in a tie" do
        Vote.destroy_all
        perform_vote(Work.first, User.first)
        perform_vote(Work.second, User.first)
        expect(Work.spotlight).must_equal Work.second
      end
    end

    describe "top ten" do
      it "returns top ten voted works" do
        Vote.destroy_all
        categories = ["album", "movie", "book"]

        categories.each do |category|
          Work.destroy_all
          # creates and votes for 11 works, per category
          11.times do |i|
            work = Work.create!(title: "test #{i}", category: category)
            perform_vote(work, User.first)
          end

          # votes a second time for the first work
          first_work = Work.where(category: category).first
          perform_vote(first_work, User.second)

          expect(Work.top_ten(category).count).must_equal 10
          expect(Work.top_ten(category).first).must_equal first_work
        end
      end

      it "returns all works if less than 10 works" do
        categories = ["album", "movie", "book"]

        categories.each do |category|
          Work.destroy_all
          7.times do |i|
            work = Work.create!(title: "test #{i}", category: category)
            expect(Work.top_ten(category)).must_include work
            expect(Work.top_ten(category).count).must_equal (i + 1)
          end
        end
      end
    end
  end
end
