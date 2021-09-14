class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices, id: false do |t|
      t.integer :id
      t.references :customer, foreign_key: true
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
    end
    execute "ALTER TABLE invoices ADD PRIMARY KEY (id);"
  end
end
