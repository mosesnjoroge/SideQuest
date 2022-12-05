class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :new_parameters, if: :devise_controller?

  def new_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end

  def add_back_links
    @sidequest = SideQuest.all
    @trip = Trip.all
    @review = Review.all
  end
end
