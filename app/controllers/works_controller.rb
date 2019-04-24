class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  # def top_10_media_by_category(category)
  #   @all_media_in_category = Work.where(category: category)
  # end

  def show
    @work = Work.find_by(id: params[:id])
    if !@work
      head :not_found
    end
  end
end
