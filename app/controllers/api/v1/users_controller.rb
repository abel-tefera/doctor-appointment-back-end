class Api::V1::UsersController < ApplicationController
  def new_session
    return unless request.content_type == 'application/json'

    user = User.where('lower(user_name) = ?', user_params[:user_name].downcase).first

    if user.nil?
      new_user = User.create!(user_name: user_params[:user_name])
      msg = {
        id: new_user.id,
        user_name: new_user.user_name,
        message: 'user created'
      }
    else
      msg = {
        id: user.id,
        user_name: user.user_name,
        message: 'success'
      }
    end
    render json: msg, status: :ok
  end

  def index
    render json: "Welcome to Doctor's Appointment Backend. Built with Ruby on Rails. You can find the API documentation on /api/v1/api-docs",
           status: :ok
  end

  def user_params
    params.require(:user).permit(:user_name)
  end
end
