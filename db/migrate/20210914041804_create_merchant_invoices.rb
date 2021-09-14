class CreateMerchantInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :merchant_invoices do |t|
      t.references :merchant, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
