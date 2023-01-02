class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.bigint :customer_id
      t.integer :status
      t.timestamps
    end
  end
end
