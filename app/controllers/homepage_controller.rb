class HomepageController < ApplicationController
  def index
    # @works = Work.all.order(:title)

    @spotlight = Work.media_spotlight

    if @spotlight.nil?
      @no_data = "Not Found"
    else
      @albums = Work.top_10("album")
      @books = Work.top_10("book")
      @movies = Work.top_10("movie")
    end
  end
end
