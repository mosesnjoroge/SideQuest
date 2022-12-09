require 'json'
require 'net/http'
class TripsController < ApplicationController
  before_action :set_trip, only: %i[show update destroy edit]
  #before_action :set_sidequest, only: %i[index]

  PRINT_LOGS = true

  def index
    @trips = current_user.trips
    @trips = Trip.all
  end

  def show
    # Show controller should only show the SQ that are a part of the trip
    @sidequests = SideQuest.all
    @locations = Location.limit(2)
    @markers = @sidequests.geocoded.map do |sidequest|
      {
        lat: sidequest.latitude,
        lng: sidequest.longitude,
        info_window: render_to_string(partial: "info_window", locals: {sidequest: sidequest})
      }
    end
    @locations.geocoded.each do |location|
      @markers << { lat: location.latitude, lng: location.longitude, is_start_end: true,
      info_window: render_to_string(partial: "info_location", locals: {location: location}),
      image_url: helpers.asset_url("yellow.png") }
    end
    @sidequests2 = SideQuest.first(6)
    # query mapbox directions api
    # https://api.mapbox.com/directions/v5/mapbox/driving/{latStart},{lonStart};{latEnd},{lonEnd}?access_token=ENV['MAPBOX_API_KEY']
  end

  def new
    @sidequest = SideQuest.first
    @trip = Trip.new
    #@category = Trip.new
    #@location = Location.new
  end

  def create
    @trip = Trip.new(trip_params)
    # @sidequests = SideQuest.all
    @trip.user = current_user
    if @trip.save
      redirect_to edit_trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end

  def update; end

  def edit
    start_location = @trip[:start_location]
    end_location = @trip[:end_location]
    start_geo_result = Geocoder.search(start_location)
    end_geo_result = Geocoder.search(end_location)
    # stringify coords for url
    start_coords = start_geo_result.first.coordinates.reverse.join('%2C')
    end_coords = end_geo_result.first.coordinates.reverse.join('%2C')
    coordinates = [start_coords, end_coords].join('%3B')

    mapbox_api_url = URI("https://api.mapbox.com/directions/v5/mapbox/driving/#{coordinates}?alternatives=false&geometries=geojson&language=en&overview=full&steps=false&access_token=#{ENV['MAPBOX_API_KEY']}")
    mapbox_api_response = Net::HTTP.get_response(mapbox_api_url).body
    mapbox_api_json = JSON.parse(mapbox_api_response)
    route_info = mapbox_api_json['routes'][0]
    points = route_info['geometry']['coordinates']
    trip_distance_in_meters = route_info['distance']
    search_radius = trip_distance_in_meters / 1_000 / 10
    @sidequests = get_sidequests_within_radius_of_route(points, search_radius)
    @markers = @sidequests.map do |sidequest|
      {
        lat: sidequest.latitude,
        lng: sidequest.longitude,
        info_window: render_to_string(partial: "info_window", locals: {sidequest: sidequest})
      }
    end
    @locations = Location.limit(2)
    @locations.geocoded.each do |location|
      @markers << { lat: location.latitude, lng: location.longitude, is_start_end: true,
      info_window: render_to_string(partial: "info_location", locals: {location: location}),
      image_url: helpers.asset_url("yellow.png") }
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def distance(first, second)
    Geocoder::Calculations.distance_between(first, second)
  end

  def simplify_coordinate_list(points, radius)
    next_point_proximity_to_skip = radius / 15
    every_nth_point = [points.first]

    i = 0
    j = 1
    while i <= points.size do
      this_point = points[i]
      next_point = points[i+j]

      break if next_point.blank?

      these_coords = [this_point.first, this_point.second]
      next_coords = [next_point.first, next_point.second]

      km_to_next_point = distance(these_coords, next_coords)
      next_point_is_too_close = km_to_next_point < next_point_proximity_to_skip

      if next_point_is_too_close
        j = j + 1
      else
        every_nth_point << points[i+j]
        i = i + j
        j = 1
      end
    end

    every_nth_point << points.last
  end

  def get_sidequests_within_radius_of_route(points, radius)
    simplified_points = simplify_coordinate_list(points, radius)
    possible_sidequests = []
    simplified_points.map do |point|
      sidequests_near_point = SideQuest.near(point.reverse, radius)
      possible_sidequests.concat(sidequests_near_point) unless sidequests_near_point.blank?
    end
    possible_sidequests.uniq!
  end

  def trip_params
    params.require(:trip).permit(:start_location, :end_location, :categories)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def set_sidequest
    @sidequest = SideQuest.find(params[:id])
  end

  def set_category
    @category = Category.find(side_quest_id: params[:id])
  end
end
