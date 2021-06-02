class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_enum :invoice_status, %w[in_progress cancelled completed]

    create_table :invoices do |t|
      t.enum :status, enum_name: :invoice_status
      t.references :customer_id, foreign_key: true

      t.timestamps
    end
  end
end
