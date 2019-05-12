class WorksController < ApplicationController
  # t.string :category
  # t.string :title
  # t.string :creator
  # t.date :publication_year
  # t.string :description

  def index
    @works_by_category = Work.all.group_by { |work| work.category }
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path(@work), notice: "Successfully created #{@work.category} #{@work.id}"
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to works_path(@work), notice: "Successfully updated #{@work.category} #{@work.id}"
    else
      render :new
    end
  end

  def show
    @work = Work.find(params[:id])
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

  def vote
    user = current_user

    unless user
      flash[:status] = :error
      flash[:message] = "you must be logged in to vote"
      redirect_back(fallback_location: home_path)
      return
    end

    work_id = params[:id].to_i

    unless params.key? :value
      flash[:status] = :error
      flash[:message] = "Please provide a valid vote value, 1 or -1"
      redirect_back(fallback_location: work_path(work_id))
      return
    end

    vote_params = {
      value: params[:value].to_i,
      work_id: work_id,
      user_id: user.id,
      date: Date.today,
    }

    previous_vote = Vote.where(work_id: work_id, user_id: user.id)

    if previous_vote.empty?
      Vote.create(vote_params)
    else
      previous_vote.update(vote_params)
    end

    redirect_back(fallback_location: work_path(work_id))
  end

  def homepage
    @works_by_category = Work.all.group_by { |work| work.category }
  end

  private

  def current_user
    User.find_by(id: session[:user_id])
  end

  def work_params
    work_params = params.require(:work).permit(
      :category,
      :title,
      :creator,
      :publication_year,
      :description
    )
    work_params[:publication_year] = Date.strptime(
      work_params[:publication_year], "%Y"
    )
    return work_params
  end
end
