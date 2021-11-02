namespace :csv_load do
  task customers: :environment do
    Customer.destroy_all
    csv.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end
end
