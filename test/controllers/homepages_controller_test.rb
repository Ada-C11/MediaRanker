require "test_helper"

describe HomepagesController do
  before do
    @work = Work.create!(category: "test work", title: 'title', creator: 'Someone', publication_year: 2016, description: 'About a book', votes: 2)
  end
  describe "index" do
    it "renders without crashing" do
      get works_path

      must_respond_with :ok
    end
  end

end
