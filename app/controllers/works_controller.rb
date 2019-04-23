class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    @work = Work.find_by(id: params[:id])

    unless @work
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

#   def edit
#     @passenger = Passenger.find_by(id: params[:id])
#     unless @passenger
#       redirect_to passengers_path
#     end
#   end    
end
