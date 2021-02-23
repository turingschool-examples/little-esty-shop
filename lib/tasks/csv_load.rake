require 'CSV'
require 'rake'
# Dir["./app/models/*.rb"].each {|file| require file }

namespace :csv_load do
  desc "load merchant database"
  task :merchants => [:environment] do
    Merchant.destroy_all
    file = CSV.readlines('./db/data/merchants.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      Merchant.create!(
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
  end
end