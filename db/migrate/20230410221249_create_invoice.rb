class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.string :status
      t.string :timestamps
    end
  end
end
