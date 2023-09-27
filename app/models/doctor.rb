class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :user
  attribute :image, :binary

  validates :name, presence: true
  validates :bio, presence: true
  validates :hospital, presence: true
  validates :specialization, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :image, presence: true
end
