class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :appointment_date, presence: true
  validates :appointment_date, uniqueness: { scope: :doctor_id }
  validates :appointment_date, uniqueness: { scope: :user_id }
end
