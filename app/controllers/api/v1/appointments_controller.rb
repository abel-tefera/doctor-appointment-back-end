class Api::V1::AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.new(appointment_params)
    
    @appointments = Appointment.where("user_id = :user_id or doctor_id = :doctor_id", { user_id: params[:user_id], doctor_id: params[:doctor_id] })

    @appointments.each do |appointment|
      if appointment.doctor_id == params[:doctor_id].to_i && appointment.appointment_date == @appointment.appointment_date
        render json: { error: 'Doctor is not available at this time' }, status: 422
        return 
      elsif 
        appointment.user_id == params[:user_id].to_i && appointment.appointment_date == @appointment.appointment_date
        render json: { error: 'User already has an appointment at this time' }, status: 422
        return
      end
    end

    if @appointment.save
      render json: {
        id: @appointment.id,
        user: @appointment.user.user_name,
        doctor: @appointment.doctor.name,
        hospital: @appointment.doctor.hospital,
        date: @appointment.appointment_date,
        rate: @appointment.doctor.rate
      }
    else
      render json: { error: 'Error creating appointment' }, status: 500
    end
  end

  def find_all
    @user_appointments = Appointment.where(user_id: params[:user_id]).includes(:user, :doctor)
    @appointments_info = []
    @user_appointments.each do |appointment|
      @appointments_info.push({
                                id: appointment.id,
                                user: appointment.user.user_name,
                                doctor: appointment.doctor.name,
                                hospital: appointment.doctor.hospital,
                                date: appointment.appointment_date,
                                rate: appointment.doctor.rate
                              })
    end
    render json: @appointments_info, status: 200
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id, :user_id)
  end
end
