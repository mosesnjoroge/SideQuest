class LocationsController < ApplicationController
  before_action :set_location, only: %i[destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    #@location = Location.create(set_params)
    #@location.user = current_user
    #if @location.save!
     @trip = Trip.first
      redirect_to trip_path(@trip), notice: "Your Trip was successfully created"
    #redirect_to trip_path(@trip), notice: "Your Trip was successfully created"

    #else
     #redirect_to root_path, notice: "Location details were not correct"
    #end
    #vo
  end

  def destroy
    @location.destroy
    redirect_to root_path, notice: 'Your details were not correct, try again'
  end

  private

  def set_params
    params.require(:location).permit()
    #params.require(:location).permit(:name, :address)
  end

  def set_location
    @location = Location.find(params[:id])
  end
end
