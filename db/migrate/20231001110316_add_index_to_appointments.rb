class AddIndexToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_index :appointments, [:user_id, :appointment_date], unique: true
    add_index :appointments, [:doctor_id, :appointment_date], unique: true
  end
end
