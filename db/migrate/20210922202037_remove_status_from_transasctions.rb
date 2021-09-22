class RemoveStatusFromTransasctions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :result
  end
end
