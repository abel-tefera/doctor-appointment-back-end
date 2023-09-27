class Api::V1::DoctorsController < ApplicationController
  def index
    all_doctors = Doctor.pluck(:id, :name, :bio, :hospital, :specialization, :rate,
                               :image).map do |id, name, bio, hospital, specialization, rate, image|
      { id:, name:, bio:, hospital:, specialization:, rate:,
        image: Base64.encode64(image) }
    end
    render json: all_doctors
  end

  def three_first_doctors
    all_doctors = Doctor.pluck(:id, :name, :bio, :hospital, :specialization, :rate,
                               :image).map do |id, name, bio, hospital, specialization, rate, image|
      { id:, name:, bio:, hospital:, specialization:, rate:,
        image: Base64.encode64(image) }
    end
    doctors = all_doctors.shuffle.sample(3)
    render json: doctors
  end

  def create
    user_id = params[:doctor][:user_id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      render json: { error: 'User not found' }, status: :not_found
      return
    end    

    @doctor = @user.doctors.build(doctor_create_params)    

    if @doctor.save
      render json: @doctor, status: :created      
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:id, :name, :bio, :hospital, :specialization, :rate, :images)
  end

  def doctor_create_params
    params.require(:doctor).permit(:name, :bio, :specialization, :rate, :hospital, :image, :user_id)    
  end 
end
