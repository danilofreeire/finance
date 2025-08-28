class Transaction < ApplicationRecord
  belongs_to :account, optional: true
end
