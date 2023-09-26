class Api::V1::AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment
    else
      render json: { error: 'Error creating appointment' }
    end
  end

  def find_all
    @user_appointments = Appointment.where(user_id: params[:user_id])
    @appointments_info = []
    @user_appointments.each do |appointment|
      @appointments_info.push({
                                id: appointment.id,
                                user: appointment.user.user_name,
                                doctor: appointment.doctor.name,
                                hospital: appointment.doctor.hospital,
                                date: appointment.appointment_date
                              })
    end
    render json: @appointments_info
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id, :user_id)
  end
end
