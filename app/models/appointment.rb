class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :appointment_date,
            presence: true,
            uniqueness: { scope: %i[user_id doctor_id] },
            date: { after_or_equal_to: proc { Date.today } }
end
