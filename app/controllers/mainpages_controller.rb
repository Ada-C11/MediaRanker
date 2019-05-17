class MainpagesController < ApplicationController
  def index
    @categories = Category.all
  end
end
