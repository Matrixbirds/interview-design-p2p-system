class WithdrawalsController < ApplicationController
  before_action :validate_params, only: [:create]
  def create
    current_user.create_
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
