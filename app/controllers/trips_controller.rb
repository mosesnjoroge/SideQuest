class TripsController < ApplicationController

  before_action :set_trip, only: [:create]

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip.user = current_user
    if @trip.save!
      redirect_to trips_path, notice: "Your trip was successfully created"
    else
      redirect_to new_trip_path, notice "Your trip details were not correct, try again"
    end
  end

  def show

  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
