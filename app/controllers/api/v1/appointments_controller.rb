class Api::V1::AppointmentsController < ApplicationController
    def create
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
            render json: @appointment
        else
            render json: {error: 'Error creating appointment'}
        end
    end
    
    private
    
    def appointment_params
        params.require(:appointment).permit(:appointment_date, :doctor_id, :user_id)
    end
end