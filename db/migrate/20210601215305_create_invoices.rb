class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :status

      t.references :customer, foreign_key: true

      t.timestamps
    end
    execute("ALTER SEQUENCE invoices_id_seq START with 1000 RESTART;")
  end
end
