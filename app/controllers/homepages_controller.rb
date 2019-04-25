class HomepagesController < ApplicationController
  def index
    @works = Work.all

    @spotlight_work = @works.first
    @works.each do |work|
      if work.vote_count > @spotlight_work.vote_count
        @spotlight_work = work
      end
    end

    # @top_book =
    # @top_movie =
    # @top_album =
  end
end
