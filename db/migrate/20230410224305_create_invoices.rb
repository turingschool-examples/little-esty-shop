class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|

      t.integer :status, null: false
      t.integer :customer_id, null: false #created this column from CSV
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      # t.references :customer, foreign_key: true, null: false
    end
  end
end
