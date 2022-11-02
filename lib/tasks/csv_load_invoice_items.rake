require 'csv'

status_hash = {'pending' => 0, 'packaged' => 1, 'shipped' => 2}

namespace :csv_load do
  desc 'This task loads data for the invoice_items'
  task invoice_items: [:environment] do
    file = Rails.root.join('db', 'data', 'invoice_items.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = InvoiceItem.new
      t.id = row['id']
      t.item_id = row['item_id']
      t.invoice_id = row['invoice_id']
      t.quantity = row['quantity']
      t.unit_price = row['unit_price']
      t.status = status_hash[row['status']]
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end