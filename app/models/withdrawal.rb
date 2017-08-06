class Withdrawal < ApplicationRecord
  belongs_to :producer, class_name: 'User', foreign_key: 'producer_id', required: true
  belongs_to :consumer, class_name: 'User', foreign_key: 'consumer_id', required: true
end
