class StopsController < ApplicationController
  before_action :set_sidequest, only: %i[new]
  before_action :set_trip, only: %i[new]



  def new
  @stop = Stop.new()
  @stop.side_quest = @sidequest
  @stop.trip = @trip
  if Stop.last == nil
    @stop.order = 1
  else
    @stop.order = (Stop.last.id) + 1
  end
  raise
  if @stop.save
    redirect_to side_quests_path, notice: "#{@sidequest.name} was successfully added to your trip"
  else
    redirect_to side_quests_path, notice: "We failed to add #{@sidequest.name} to your trip, please try again"
  end
  end

#yellow as a sidequest
  # create_table "stops", force: :cascade do |t|
  #   t.bigint "trip_id", null: false
  #   t.bigint "side_quest_id", null: false
  #   t.integer "order"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["side_quest_id"], name: "index_stops_on_side_quest_id"
  #   t.index ["trip_id"], name: "index_stops_on_trip_id"
  # end


  def set_sidequest
  @sidequest =  SideQuest.find(params[:side_quest_id])
  end

  private

  def set_trip
    @trip = Trip.first
  end
end
