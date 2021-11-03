class CreateMerchant < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants,  :id => false do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
    execute 'ALTER TABLE merchants ADD PRIMARY KEY (id);'
  end
end
