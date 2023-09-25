class Api::V1::DoctorsController < ApplicationController
  
  def index
    doctors = Doctor.pluck(:name, :bio, :hospital, :specialization, :rate, :image).map do |name, bio, hospital, specialization, rate, image|
      { name: name, bio: bio, hospital: hospital, specialization: specialization, rate: rate, image: Base64.encode64(image) }
    end
    render json: doctors
  end


  private

  def doctor_params
    params.require(:doctor).permit(:name, :bio, :hospital, :specialization, :rate, :images)
  end
end
