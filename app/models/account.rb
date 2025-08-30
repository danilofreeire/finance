# frozen_string_literal: true

class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :transactions, dependent: :destroy
  belongs_to :user
  enum :kind, {
    checking: 0, # conta corrente
    savings: 1, # poupança
    cash: 2, # dinheiro
    wallet: 3, # carteira digital
    credit_card: 4, # cartão de crédito
    investment: 5, # investimentos
    loan: 6, # empréstimos
    other: 7,
  }
end
