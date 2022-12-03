class CategoryController < ApplicationController
  before_action :set_trip

  def index
    @categorys = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.user = current_user
    if @category.save
      redirect_to trip_path(@trip)
    else
      redirect_to new_trip_path
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def category_params

  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
