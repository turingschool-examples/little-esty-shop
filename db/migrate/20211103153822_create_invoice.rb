class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices, :id => false do |t|
      t.integer :id
      t.references :customer, foreign_key: true
      t.column :status, :integer, default: 0

      t.timestamps
    end
    execute 'ALTER TABLE invoices ADD PRIMARY KEY (id);'
  end
end
