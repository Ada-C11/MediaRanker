class HomepagesController < ApplicationController
  def index
    @featured = Work.featured
    @works = Work.all
  end
end
