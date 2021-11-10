class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.string :status, default: "able"
    end
  end
end
