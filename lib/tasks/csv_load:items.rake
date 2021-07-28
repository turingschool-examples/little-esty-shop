require 'csv'

namespace :csv_load do
  desc "Imports Item CSV file into an ActiveRecord table"
  task :items => :environment do
    Item.destroy_all
    file = './db/data/items.csv'
    CSV.foreach(file, :headers => true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:item)
  end
end
