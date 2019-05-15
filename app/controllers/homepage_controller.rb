class HomepageController < ApplicationController
  def index
    @spotlight = Work.all.sample
  end
end
