class ChangeDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :enable, :integer, :default => 1
  end
end
