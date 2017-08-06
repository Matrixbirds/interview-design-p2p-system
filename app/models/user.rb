class User < ApplicationRecord
  has_secure_password
  has_one :wallet
  has_many :withdrawals, foreign_key: 'producer_id'
  has_many :deposits, foreign_key: 'producer_id'
  validates :password, presence: true
  validates :name, presence: true, uniqueness: true

  def token
    JsonWebToken.encode self.as_json(only: [:id, :name])
  end

  def self.authenticate! args={}
    user = User.find_by_name(args[:name])
    raise UnauthorizedError.new("用户名不存在") if user.blank?
    raise UnauthorizedError.new("密码错误") unless user.authenticate(args[:password])
    user
  end

end
