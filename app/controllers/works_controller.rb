class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def new
    @work = Work.new(category: "Category", title: "Title", creator: "Creator", publication_year: "Publication Year", description: "Description")
  end
end
