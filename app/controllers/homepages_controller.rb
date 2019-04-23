class HomepagesController < ApplicationController

  def index
    @works = Work.all.sort_by(&:id)
    @spotlight = @works.sample
    top_ten_movies
    top_ten_books
    top_ten_albums
  end
end
