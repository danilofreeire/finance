# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table(:accounts, id: :uuid) do |t|
      t.string(:name)
      t.string(:kind)
      t.decimal(:opening_balance)

      t.timestamps
    end
  end
end
