class UpdateStatusDefaultToZero < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :status, from: nil, to: 0
  end
end
