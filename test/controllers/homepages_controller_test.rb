require "test_helper"

describe HomepagesController do
  describe "index" do
    it "renders without crashing" do
      get home_path

      must_respond_with :ok
    end

    it "return top 10 movies" do
      10.times do |i|
        Work.create!(
          category: "test work",
          title: 'title',
          creator: 'Someone',
          publication_year: 2016,
          description: 'About a book',
          number_of_votes: i
        )
      end
      expect
    end

    it "determines spotlight based on number of votes" do
      10.times do |i|
        Work.create!(
          category: "test work",
          title: 'title',
          creator: 'Someone',
          publication_year: 2016,
          description: 'About a book',
          number_of_votes: i
        )
      end
    end
  end
end
