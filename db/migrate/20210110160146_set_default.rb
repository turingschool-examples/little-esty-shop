class SetDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :merchants, :status, :integer, default: 0
  end
end
