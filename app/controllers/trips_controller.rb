require 'json'
require 'net/http'

class TripsController < ApplicationController
  before_action :set_trip, only: %i[show update destroy edit]

  def index
    @trips = current_user.trips
  end

  def show
    @sidequests = @trip.stops.map { |stop| stop.side_quest }

    @markers = @sidequests.map do |sidequest|
      {
        lat: sidequest.latitude,
        lng: sidequest.longitude,
        name: sidequest.name,
        address: sidequest.address,
        stop_is_in_trip: Stop.where(trip: @trip, side_quest: sidequest).size.positive?,
        image_url: helpers.asset_url("gray.png"),
        info_window: render_to_string(partial: "info_window", locals: { sidequest: sidequest }),
        trip_stop: true
      }
    end

    # Sort the markers based on proximity to start_geolocation
    @markers.sort! do |a, b|
      # Calculate the distances of each marker to start_geolocation
      distance_a = calculate_distance(a[:lat], a[:lng], @trip.start_geolocation['lat'], @trip.start_geolocation['lon'])
      distance_b = calculate_distance(b[:lat], b[:lng], @trip.start_geolocation['lat'], @trip.start_geolocation['lon'])

      # Compare distances
      distance_a <=> distance_b
    end

    start_end_markers = [@trip.start_geolocation, @trip.end_geolocation].map do |location|
      {
        lat: location['lat'],
        lng: location['lon'],
        is_start_end: true,
        image_url: helpers.asset_url("red.png")
      }
    end
    @markers.unshift(start_end_markers.first)
    @markers.push(start_end_markers.last)
  end

  def new
    @sidequest = SideQuest.first
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    start_results = Geocoder.search(@trip[:start_location])
    end_results = Geocoder.search(@trip[:end_location])

    if start_results.blank? || end_results.blank?
      Trip.find(@trip.id).destroy
      redirect_to new_trip_path(), notice: "One or more of your addresses was not found"
      return false
    end

    @trip.start_geolocation = start_results.first.data
    @trip.end_geolocation = end_results.first.data

    @trip.user = current_user
    if @trip.save
      redirect_to edit_trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end

  def update; end

  def edit
    route_info = get_mapbox_route_info_for_trip(@trip[:start_location], @trip[:end_location])

    points = route_info['geometry']['coordinates']
    trip_distance_in_meters = route_info['distance']
    search_radius = trip_distance_in_meters / 1_000 / 5

    @sidequests = get_sidequests_within_radius_of_route(points, search_radius)

    @markers = @sidequests.map do |sidequest|
      {
        lat: sidequest.latitude,
        lng: sidequest.longitude,
        info_window: render_to_string(partial: "info_window", locals: {sidequest: sidequest}),
        stop_is_in_trip: Stop.where(trip: @trip, side_quest: sidequest).size.positive?,
        image_url: helpers.asset_url("gray.png")
      }
    end


    start_end_markers = [points.first, points.last].map do |location|
      {
        lat: location.last,
        lng: location.first,
        is_start_end: true,
        image_url: helpers.asset_url("yellow.png")
      }
    end

    @markers.unshift(start_end_markers.first)
    @markers.push(start_end_markers.last)
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def calculate_distance(lat1, lon1, lat2, lon2)
    # Use the Haversine formula to calculate the distance
    rad_lat1 = deg2rad(lat1.to_f)
    rad_lon1 = deg2rad(lon1.to_f)
    rad_lat2 = deg2rad(lat2.to_f)
    rad_lon2 = deg2rad(lon2.to_f)

    dlon = rad_lon2 - rad_lon1
    dlat = rad_lat2 - rad_lat1

    a = Math.sin(dlat / 2)**2 + Math.cos(rad_lat1) * Math.cos(rad_lat2) * Math.sin(dlon / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    distance = 6371 * c # Radius of the Earth in km

    return distance
  end

  # Convert degrees to radians
  def deg2rad(deg)
    return deg * (Math::PI / 180)
  end

  def get_mapbox_route_info_for_trip(start_location, end_location)
    start_geo_result = Geocoder.search(start_location).first
    end_geo_result = Geocoder.search(end_location).first

    start_coords = start_geo_result.coordinates.reverse.join('%2C')
    end_coords = end_geo_result.coordinates.reverse.join('%2C')
    coordinates = [start_coords, end_coords].join('%3B')

    mapbox_api_url = URI("https://api.mapbox.com/directions/v5/mapbox/driving/#{coordinates}?alternatives=false&geometries=geojson&language=en&overview=full&steps=false&access_token=pk.eyJ1IjoicnRpZXJyZSIsImEiOiJjbDhxYmhkdjQwMXhoNDFvZzZ6NXZhbjl4In0.wVQDleC1CAHET3pVLdKoQA")
    mapbox_api_response = Net::HTTP.get_response(mapbox_api_url).body
    mapbox_api_json = JSON.parse(mapbox_api_response)
    mapbox_api_json['routes'][0]
  end


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
    possible_sidequests.uniq! || []
  end
end

  def trip_params
    params.require(:trip).permit(:start_location, :end_location, :categories)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def set_sidequest
  end

  def set_category
    @category = Category.find(side_quest_id: params[:id])
  end
