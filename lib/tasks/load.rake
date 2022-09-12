require 'csv'

namespace :csv_load do
  desc "This task loads a csv to the seed file"
  task customers: :environment  do
    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
    Customer.create!({
      id: row[0],
      first_name: row[1],
      last_name: row[2]})
    end
  end
  # desc ""
  # task do
  # end

  # desc ""
  # task do
  # end
end
