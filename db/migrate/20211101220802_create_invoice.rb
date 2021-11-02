class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices, :id => false do |t|
      t.integer :id
      t.integer :customer_id
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
