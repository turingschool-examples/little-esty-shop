require 'csv'

namespace :csv_load do

  desc 'seed data from Customers.csv'

  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end
