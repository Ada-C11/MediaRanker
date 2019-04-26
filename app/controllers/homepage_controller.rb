class HomepageController < ApplicationController
  def index
    @works = Work.all.order(:title)

  end
end
