class LocationsController < ApplicationController
  before_action :set_location, only: %i[destroy]

  def index
    @locations = Location.all
    raise
  end

  def new
    @location = Location.new
  end

  def create
    # stringify coords for url
start_coords = params[:location].join('%2C')
end_coords = @params[:place1].join('%2C')
coordinates = [start_coords, end_coords].join('%3B')

mapbox_api_url = URI("https://api.mapbox.com/directions/v5/mapbox/driving/#{coordinates}?alternatives=false&geometries=geojson&language=en&overview=full&steps=false&access_token=#{ENV['MAPBOX_API_KEY']}")
mapbox_api_response = Net::HTTP.get_response(mapbox_api_url).body
mapbox_api_json = JSON.parse(mapbox_api_response)
route_info = mapbox_api_json['routes'][0]

pp route_info

    #@location = Location.create(set_params)
    #@location.user = current_user
    #if @location.save!
     @trip = Trip.first
      redirect_to trip_path(@trip), notice: "Your Trip was successfully created"
    #redirect_to trip_path(@trip), notice: "Your Trip was successfully created"

    #else
     #redirect_to root_path, notice: "Location details were not correct"
    #end
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
