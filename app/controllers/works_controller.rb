class WorksController < ApplicationController
  def index
    @works = Work.all
    @featured_work = @works.sample
  end

  def show
    work_id = params[:id]

    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end

  def edit
    work_id = params[:id]

    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end
end
