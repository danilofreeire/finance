# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  enum kind: { income: 0, expense: 1 }
end
