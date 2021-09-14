class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true, null: false
      t.integer :status, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
