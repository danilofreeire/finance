# frozen_string_literal: true

class AddUserToAccount < ActiveRecord::Migration[7.1]
  def change
    add_reference(:accounts, :user, null: false, foreign_key: true, type: :uuid)
  end
end
