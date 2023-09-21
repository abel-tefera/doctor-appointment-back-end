class User < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :doctors, dependent: :destroy

  validates :user_name, presence: true
end
