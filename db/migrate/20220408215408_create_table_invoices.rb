class CreateTableInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :table_invoices, id: false do |t|
      t.bigint :id
      t.references :customer, foreign_key: true
      t.integer :status, default: 0
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
