class WorksController < ApplicationController
    def index
        @works = Work.all
    end

    def new
        @work = Work.new
    end

    def create
        @work = Work.new(work_params)
        
        successful = @work.save

        if successful
            redirect_to work_path(@work.id)
        else 
            render :new
        end
    end

    def show
        work_id = params[:id]
        @work = Work.find_by(id: work_id)

        if @work.nil?
            redirect_to works_path
        end
    end

    def edit
        work_id = params[:id]
        @work = Work.find_by(id: work_id)

        if @work.nil?
            redirect_to works_path
        end
    end

    def update
        work_id = params[:id]
        work = Work.find_by(id: work_id)

        if work.nil?
            redirect_to works_path
            return
        end

        work.update(work_params)

        redirect_to work_path(work.id)
    end
end


def destroy
    work_id = params[:id]

    work = Work.find_by(id: work_id)

   unless work
    head :not_found
    return
   end

    work.destroy

    redirect_to works_path
end

private

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
