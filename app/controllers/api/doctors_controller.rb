class Api::DoctorsController < ApplicationController
  
  def index
    doctors = Doctor.pluck(:name, :hospital, :image).map do |name, hospital, image|
      { name: name, hospital: hospital, image: Base64.encode64(image) }
    end
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
