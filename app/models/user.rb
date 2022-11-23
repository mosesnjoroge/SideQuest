class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trips, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :side_quests, dependent: :destroy
  has_one_attached :avatar

  # geocoded_by :address
  # after_validation :geocode, if:
  # :will_save_change_to_address?
end
