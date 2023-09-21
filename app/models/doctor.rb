class Doctor < ApplicationRecord

    has_many :appointments, dependent: :destroy
    belongs_to :user
  
    validates :name, presence: true
    validates :bio, presence: true
    validates :hospital, presence: true
    validates :specialization, presence: true
    validates :rate, presence: true, numericality: { greater_than: 0 }
    validates :images, presence: true

  
end
