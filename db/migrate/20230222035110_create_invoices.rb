class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :uuid
      t.references :customer, foreign_key: true
      t.integer :status
      
      t.timestamps
    end
  end
end
