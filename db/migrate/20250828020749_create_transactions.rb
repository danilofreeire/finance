# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table(:transactions, id: :uuid) do |t|
      t.date(:date)
      t.float(:amount)
      t.string(:kind)
      t.text(:description)

      t.timestamps
    end
  end
end
