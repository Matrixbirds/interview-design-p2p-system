class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :validate_params, only: [:create]
  def create
    ActiveRecord::Base.transaction do
      @user = User.create!(user_params)
      Wallet.create!(wallet_params.tap do |e|
        e[:user_id] = @user.id
      end)
    end
    render json: @user, serializer: UserSerializer,
      status: :created
  end

  private
  def validate_params
    param! :data, Hash, required: true do |data|
      data.param! :name, String, required: true
      data.param! :password, String, required: true
      data.param! :balance, Float, required: true
    end
  end

  def data_params
    params.require(:data).permit(:name, :balance, :password)
  end

  def user_params
    data_params.except("balance")
  end

  def wallet_params
    data_params.as_json(only: "balance")
  end
end
