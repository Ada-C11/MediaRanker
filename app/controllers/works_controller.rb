class WorksController < ApplicationController
  def index
    @works = Work.all.order(:title)
  end
end
