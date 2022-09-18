class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :status, :null => false, :default => "Enabled"

      t.timestamps
    end
  end
end
