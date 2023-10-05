class Api::V1::AppointmentsController < ApplicationController
  def create
    @new_appointment = Appointment.new(appointment_params)

    if @new_appointment.appointment_date < Date.today
      return render json: { error: 'Please select a date not in the past' }, status: 422
    end

    @appointments = Appointment.where('user_id = :user_id or doctor_id = :doctor_id',
                                      { user_id: params[:user_id], doctor_id: params[:doctor_id] })

    @appointments.each do |appointment|
      if appointment.doctor_id == params[:doctor_id].to_i &&
         appointment.appointment_date == @new_appointment.appointment_date
        return render json: { error: 'Doctor is not available on this day' }, status: 422
      elsif appointment.user_id == params[:user_id].to_i &&
            appointment.appointment_date == @new_appointment.appointment_date
        return render json: { error: 'Appointment already exists on this day' }, status: 422
      end
    end

    if @new_appointment.save
      render json: {
        id: @new_appointment.id,
        user: @new_appointment.user.user_name,
        doctor: @new_appointment.doctor.name,
        hospital: @new_appointment.doctor.hospital,
        date: @new_appointment.appointment_date,
        rate: @new_appointment.doctor.rate
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
    @appointments_info.sort_by! { |appointment| appointment[:date] }
    render json: @appointments_info, status: 200
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id, :user_id)
  end
end
