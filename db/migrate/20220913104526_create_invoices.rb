class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.enum status: [ :cancelled, :in_progress, :completed ]
      t.references :customer, foreign_key: true
    end
  end
end
