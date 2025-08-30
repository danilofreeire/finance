# frozen_string_literal: true

class AddAccountToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference(:transactions, :account, null: true, foreign_key: true, type: :uuid)
  end
end
