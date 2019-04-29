class WorksController < ApplicationController
    before_action :find_work, only: [:show, :edit, :update, :destroy]

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
            flash[:status] = :success
            flash[:message] = "Successfully saved work with ID ##{@work.id}"
            redirect_to work_path(@work.id)
        else
            flash.now[:status] = :error
            flash.now[:message] = "Could not save work"
            render :new, status: :bad_request
        end
    end

    def show
        
    end

    def edit
        
    end

    def update
        if @work.update(work_params)
            flash[:status] = :success
            flash[:message] = "Successfully updated work #{@work.id}"
            redirect_to work_path(@work)
        else
            flash.now[:status] = :error
            flash.now[:message] = "Could not save edits to work ##{@work.id}"
            render :edit, status: :bad_request
        end
    end

    def destroy

        @work.destroy

        flash[:status] = :success
        flash[:message] = "Successfully deleted work #{@work.id}"
        redirect_to works_path
    end

    def upvote
        @current_user = User.find_by(id: session[:user_id])
        work_id = params[:id]
        @work = Work.find_by(id: work_id)
    
        if @current_user.nil?
          flash[:error] = "You Must Be Logged In To See This Page"
          redirect_to login_path
        elsif Vote.exists?(user_id: @current_user.id, work_id: work_id)
          flash[:error] = "You Have Already Upvoted This Title."
          redirect_to work_path(@work)
        else
          @vote = Vote.create(
            user_id: @current_user.id,
            work_id: @work.id,
          )
          flash[:success] = "Successfully Upvoted #{@work.title}"
          redirect_to user_path(@current_user.id)
        end  
      end

end


private

def work_params
  return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :user_id)
end

def find_work
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end
end