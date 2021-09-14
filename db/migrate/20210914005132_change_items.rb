class ChangeItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :id, :bigint, auto_increment: false
  end
end
