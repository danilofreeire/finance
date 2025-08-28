class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

    has_many :transactions, dependent: :destroy
end
