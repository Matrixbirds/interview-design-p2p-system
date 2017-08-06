class Deposit < ApplicationRecord
  belongs_to :producer, class_name: 'User', foreign_key: 'producer_id', required: true
  belongs_to :consumer, class_name: 'User', foreign_key: 'consumer_id', required: true

  def self.process(consumer_id, balance, current_user)
    ActiveRecord::Base.transaction(isolation: :serializable) do
      user = User.find(consumer_id)
      user.wallet.save!(balance: balance)
      current_user.wallet.save!(balance: balance)
      @res = current_user.deposits.create!({ consumer_id: consumer_id, balance: balance })
    end
    @res
  end
end
