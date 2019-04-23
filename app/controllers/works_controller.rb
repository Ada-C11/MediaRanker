class WorksController < ApplicationController
  
  def index
    @works = Works.all.sort_by(&:id)
  end
end
