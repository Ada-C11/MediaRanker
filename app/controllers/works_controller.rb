class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      flash[:status] = :error
      flash[:message] = "Could not find media with that id: #{params[:id]}"
      redirect_to works_path
      return
    end

    # @unrated_trip = @passenger.trips.find_by(rating: nil)
    # @trip = Trip.new
    # @trips = @passenger.trips
  end

  #   def new
  #     @work = Work.new
  #   end
  #
  #   def create
  #     @passenger = Passenger.new passenger_params
  #     successful = @passenger.save
  #     if successful
  #       redirect_to passengers_path
  #     else
  #       render :new
  #     end
  #   end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path, flash: { error: "Could not find media with id: #{params[:id]}" }
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


end
