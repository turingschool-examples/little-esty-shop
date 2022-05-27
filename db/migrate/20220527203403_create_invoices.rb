class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.reference :customers, foreign_key: true
      t.string :status
    end
  end
end
