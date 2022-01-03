require 'csv'

desc "Import invoice_items from csv"
task :import => [:environment] do
  file = "db/data/invoice_items.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      item_id = row[1],
      invoice_id = row[2],
      quantity = row[3],
      unit_price = row[4]
      status = row[5]
      created_at = row[6]
      updated_at = row[7]

      Invoice.create(id: id,
                      item_id: item_id,
                      invoice_id: invoice_id,
                      quantity: quantity,
                      unit_price: unit_price,
                      status: status,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
end
