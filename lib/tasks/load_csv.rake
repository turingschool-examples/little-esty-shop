require 'csv'
namespace :load_csv do
  desc 'Load tables from CSV'
  task :merchants => :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end

namespace :load_csv do
  desc 'Load tables from CSV'
  task :items => :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end