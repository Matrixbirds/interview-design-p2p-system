class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :validate_params, only: [:create]
  def create
    render json: User.authenticate!(session_params), serializer: UserSerializer,
      status: :created
  end

  def show
    render json: current_user, serializer: UserSerializer,
      status: :ok
  end

  private
  def validate_params
    param! :data, Hash, required: true do |data|
      data.param! :name, String, required: true
      data.param! :password, String, required: true
    end
  end

  def session_params
    params.require(:data).permit(:name, :password)
  end
end
