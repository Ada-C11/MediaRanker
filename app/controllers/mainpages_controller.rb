class MainpagesController < ApplicationController
  def index
    @works = Work.all
  end
end
