class HomepagesController < ApplicationController

  def index
    @works = Work.all.sort_by(&:id)
    @spotlight = @works.sample
  end

end
