class TripsController < ApplicationController

before_action :set_trip, only: [:show, :update]

  def index
    @trips = Trip.all
  end

  def show
    @sidequests = SideQuest.all
    # @markers = [
    #   {
    #     lat: @sidequests.user.latitude,
    #     lng: @sidequests.user.longitude
    #   }
    # ]
  end

  def new
    @trip = Trip.new
    @category = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @sidequests = SideQuest.all
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end


  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:start_location_id, :end_location_id)
  end

  def set_trip
   @trip = Trip.find(params[:id])
  end

end
