class DepositSerializer < ActiveModel::Serializer
  attributes :id, :consumer_id, :producer_id, :balance
end
