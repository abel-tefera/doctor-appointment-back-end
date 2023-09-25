class Api::V1::DoctorsController < ApplicationController
  def index
    doctors = Doctor.pluck(:name, :bio, :hospital, :specialization, :rate,
                           :image).map do |name, bio, hospital, specialization, rate, image|
      {name:, bio:, hospital:, specialization:, rate:,
        image: Base64.encode64(image) }
    end
    render json: doctors
  end

  def show
    doctor = Doctor.find(params[:id])
    encoded_image = Base64.encode64(doctor.image)
    doctor.image = encoded_image

    render json: doctor
  end

  private

  def doctor_params
    params.require(:doctor).permit(:id, :name, :bio, :hospital, :specialization, :rate, :images)
  end
end
