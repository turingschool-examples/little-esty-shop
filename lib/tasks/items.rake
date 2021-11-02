namespace :csv_load do
  task items: :environment do
    Item.destroy_all
    csv.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
  end
end
