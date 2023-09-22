class Api::V1::UsersController < ApplicationController
  def new_session
    return unless request.content_type == 'application/json'

    user_name = user_params[:user_name].downcase

    user = User.where(user_name:)

    if user.empty?
      new_user = User.create!(user_name:)
      msg = {
        id: new_user.id,
        user_name: new_user.user_name,
        message: 'user created'
      }
    else
      msg = {
        id: user.first.id,
        user_name: user.first.user_name,
        message: 'success'
      }
    end
    render json: msg, status: :ok
  end

  def user_params
    params.require(:user).permit(:user_name)
  end
end
