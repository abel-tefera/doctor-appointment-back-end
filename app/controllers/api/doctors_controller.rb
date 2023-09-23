class Api::DoctorsController < ApplicationController
  
  def index
    doctors = Doctor.all
    render json: doctors
  end

  def create
    doctor = Doctor.new(doctor_params)
    
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :bio, :hospital, :specialization, :rate, :images)
  end
end
