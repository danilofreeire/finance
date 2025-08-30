class ChangeKindToIntegerInTransactions < ActiveRecord::Migration[7.1]
  def change
      change_column :transactions, :kind, :integer, using: 'kind::integer'
  end
end
