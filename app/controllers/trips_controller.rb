class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show update destroy]
  #before_action :set_sidequest, only: %i[index]

  def index
    @trips = current_user.trips
    # to be removed once the multiple trips can be displayed
    @trips = Trip.all
  end

  def show
    # @sidequests = SideQuest.all
    # @locations = Location.limit(2)
    # @markers = @sidequests.geocoded.map do |sidequest|
    #      {
    #     lat: sidequest.latitude,
    #     lng: sidequest.longitude,
    #     info_window: render_to_string(partial: "info_window", locals: {sidequest: sidequest})
    #   }
    # end
    # @locations.geocoded.each do |location|
    #   @markers << { lat: location.latitude, lng: location.longitude, is_start_end: true,
    #   info_window: render_to_string(partial: "info_location", locals: {location: location}),
    #   image_url: helpers.asset_url("yellow.png") }
    # end
    # @sidequests2 = SideQuest.first(6)
    # # query mapbox directions api
    # # https://api.mapbox.com/directions/v5/mapbox/driving/{latStart},{lonStart};{latEnd},{lonEnd}?access_token=ENV['MAPBOX_API_KEY']

    @sidequests = SideQuest.all
        @stops = SideQuest.joins("JOIN stops ON stops.trip_id = #{Trip.first.id} AND stops.side_quest_id = side_quests.id")
        @markers = @sidequests.geocoded.map do |sidequest|
          {
            lat: sidequest.latitude,
            lng: sidequest.longitude,
            info_window: render_to_string(partial: "info_window", locals: {sidequest: sidequest}),
            stop_is_in_trip: @stops.where(id: sidequest.id).size.positive?,
            image_url: helpers.asset_url("gray.png")

          }
      end
    end

  def new
    @sidequest = SideQuest.first
    @trip = Trip.new
    #@category = Trip.new
    #@location = Location.new
  end

  def create
    @trip = Trip.new
    @trip = Trip.first
    @sidequests = SideQuest.all
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end

  def update; end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

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
end
