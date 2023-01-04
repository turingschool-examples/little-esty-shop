require 'csv'

namespace :csv_load do
  desc 'load item csv into db'
  task :items do
    
    file = 'db/data/items.csv'
    
    CSV.foreach(file, headers: true) do |row|
      Item.create!(row.to_hash)
    end
    
    ActiveRecord::Base.connection.reset_pk_sequence!('item')
  end
end