require "test_helper"

describe HomepagesController do
  before do
    @work = Work.create!(category: "test work", title: 'title', creator: 'Someone', publication_year: 2016, description: 'About a book', votes: 2)
  end
  describe "index" do
    it "renders without crashing" do

    end

    it "It can randomly determine a spotlight" do

    end
  end

  describe "top ten" do
    it "it samples 10 albums" do

    end

    it "it samples 10 books" do

    end

    it "it samples 10 movies" do

    end
  end
end
