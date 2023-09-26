class Api::V1::DoctorsController < ApplicationController
  def index
    all_doctors = Doctor.pluck(:name, :bio, :hospital, :specialization, :rate,
                           :image).map do |name, bio, hospital, specialization, rate, image|
      {name:, bio:, hospital:, specialization:, rate:,
        image: Base64.encode64(image) }
    end
    render json: all_doctors
  end

  def three_first_doctors
    all_doctors = Doctor.pluck(:id, :name, :bio, :hospital, :specialization, :rate,
                          :image).map do |id, name, bio, hospital, specialization, rate, image|
      {id:, name:, bio:, hospital:, specialization:, rate:,
        image: Base64.encode64(image) }
    end
    doctors = all_doctors.shuffle.sample(3)
    render json: doctors
  end
  private

  def doctor_params
    params.require(:doctor).permit(:id, :name, :bio, :hospital, :specialization, :rate, :images)
  end
end
