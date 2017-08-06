class DepositsController < ApplicationController
  before_action :validate_params, only: [:create]
  def create
    @deposit = Deposit.process(data_params[:consumer_id], data_params[:balance], current_user)
##    ActiveRecord::Base.transaction(isolation: "SERIALIZABLE") do
##      user = User.find(data_params[:consumer_id])
##      user.wallet.save!(balance: data_params[:balance])
##      current_user.wallet.save!(balance: data_params[:balance])
##      @deposit = current_user.deposits.create!(data_params)
##    end
    raise CustomError.new("conflict", 419) unless @deposit.present?
    render json: @deposit, serializer: DepositSerializer,
      status: :created
  end

  private
  def data_params
    params.require(:data).permit(:consumer_id, :balance)
  end

  def validate_params
    param! :data, Hash, required: true do |data|
      data.param! :consumer_id, String, required: true
      data.param! :balance, Float, required: true
    end
  end
end
