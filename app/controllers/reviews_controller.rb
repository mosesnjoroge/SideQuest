class ReviewsController < ApplicationController
  before_action :set_sidequest, only: %i[index create]
  before_action :set_trip, only: %i[new create]
  
  def index
    @reviews = Review.all
  end

  def new
    @sidequest = set_sidequest
    @review = Review.new
  end

  def create
    @review = Review.create(set_params)
    @review.side_quest = @sidequest
    @review.user = current_user
    @review.save
    if @sidequest.save
      redirect_to trip_path(@trip), notice: 'your review was posted!'
    else
      redirecto_to new_side_quests_path
    end
  end

  private

  def set_sidequest
    @sidequest = SideQuest.find(params[:side_quest_id])
  end

  def set_params
    params.require(:review).permit(:body, :rating)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end
end
