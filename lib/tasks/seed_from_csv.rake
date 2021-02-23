namespace :csv_import do
  desc "Seed data.csv from db/csv_seeds to database table"
  task customer: :environment do
    require "csv"
    data = CSV.foreach('db/data/customers.csv', headers: true)

    data.each do |row|
      Customer.create!(
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end
    puts("File imported")
  end
end
