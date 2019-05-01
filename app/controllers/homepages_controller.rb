class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight
    @top_ten = Work.top_media
  end
end
