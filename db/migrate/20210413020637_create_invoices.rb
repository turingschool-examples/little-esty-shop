class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :customer_id, foreign_key: true
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
