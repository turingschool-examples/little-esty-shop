class AddTimestamps < ActiveRecord::Migration[5.2]
  def change
    tables = [:merchants, :items, :invoice_items, :invoices, :customers, :transactions]

    tables.each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime
    end
  end
end
