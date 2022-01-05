require 'csv'

desc "Import items from csv"
task :import_items_csv => [:environment] do
  file = "db/data/items.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      name = row[1],
      description = row[2],
      unit_price = row[3],
      merchant_id = row[4]
      created_at = row[5]
      updated_at = row[6]

      Item.create!(id: id,
                      name: name,
                      description: description,
                      unit_price: unit_price,
                      merchant_id: merchant_id,
                      created_at: created_at,
                      updated_at: updated_at,
                      status: 0)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('items')
end
