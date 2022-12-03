class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @trip = Trip.new
    render :layout => false
  end
end
