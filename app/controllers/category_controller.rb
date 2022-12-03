class CategoryController < ApplicationController
  before_action :set_sidequest, only: %i[index]

  def index
    if params[:query].present?
      @categories = Category.where(name: params[:query])
    else
      @categories = Category.all
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.side_quest = @sidequest
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
    @category.destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_sidequest
    @side_quest = SideQuest.find(params[:id])
  end

end
