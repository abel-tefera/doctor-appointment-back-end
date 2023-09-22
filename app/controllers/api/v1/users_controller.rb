class Api::V1::UsersController < ApplicationController
  def new_session
    return unless request.content_type == 'application/json'

    user = User.where(user_name: user_params[:user_name])
    if user.empty?
      new_user = User.create(user_params)
      msg = {
        id: new_user.id,
        user_name: new_user.user_name,
        message: 'user created'
      }
    else
      msg = {
        id: user[0].user_name,
        user_name: user[0].user_name,
        message: 'success'
      }
    end
    render json: msg, status: :ok
  end

  def user_params
    params.require(:user).permit(:user_name)
  end
end
