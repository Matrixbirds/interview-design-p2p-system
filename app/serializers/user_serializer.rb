class UserSerializer < ActiveModel::Serializer
  has_one :wallet
  has_many :deposits
  has_many :withdrawals
  attributes :id, :name, :token
end
