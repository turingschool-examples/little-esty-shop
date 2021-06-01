class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      # t.status -- enum?
      t.references :customer_id, foreign_key: true

      t.timestamps
    end
  end
end
