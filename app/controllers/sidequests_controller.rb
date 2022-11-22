class SidequestsController < ApplicationController

  before_action :set_sidequest, only: [:show, :update, :destroy]

  def index
    @sidequests = SideQuest.all
  end

  def new
    @sidequest = SideQuest.new
  end

  def create
    raise
    @sidequest = SideQuest.create(side_quest)
    @sidequest.user = current_user
    @sidequest.category = params[:category]
    if @sidequest.save!
      redirect_to sidequest_path, notice: "Sidequest was successfully created"
    else
      redirect_to new_sidequest_path, notice: "Sidequest details were not correct"
    end
  end

  def show;
  end

  def edit;
  end

  def update
    if @sidequest.update(side_quest)
      redirect_to sidequest_path, notice: "Sidequest was successfully updated"
    else
      redirect_to new_sidequest_path, notice: 'Your details were not correct, try again'
    end
  end

  def destroy
    @side_quest.destroy
    redirect_to sidequests_path, notice: 'Your details were not correct, try again'
  end

  private

  def set_params
   params.require(:sidequest).permit(:name, :address, :description, :price)
  end

  def set_sidequest
    @sidequest = SideQuest.find(params[:id])
  end
end
