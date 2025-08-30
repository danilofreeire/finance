# frozen_string_literal: true

class ChangeKindToIntegerInAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column(:accounts, :kind, :integer, using: "kind::integer")
  end
end
