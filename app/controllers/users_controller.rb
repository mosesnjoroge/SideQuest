class UsersController < ApplicationController
  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :reset_password_token, :avatar)
  end
end
