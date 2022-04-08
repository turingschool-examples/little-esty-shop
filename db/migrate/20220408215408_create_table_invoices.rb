class CreateTableInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :table_invoices do |t|
      t.bigint :id
      t.references :customer, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
