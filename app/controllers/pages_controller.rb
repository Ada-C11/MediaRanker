class PagesController < ApplicationController
  def index
    @categories = Work.categories
  end
end
