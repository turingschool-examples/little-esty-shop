# require 'csv'
# CSV.foreach('merchants.csv', :headers => true) do |row|
#   Merchant.create!(row.to_hash)
# end

# CSV.foreach('db/data/merchants.csv', headers: true) do |row|
#   Item.create(row.to_h)
# end


# require 'csv'    

# csv_text = File.read('...')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Merchant.create!(row.to_hash)
# end

task merchants: :environment do
  Merchant.destroy_all
  CSV.foreach('db/data/merchants.csv', headers: true) do |row|
    Merchant.create(row.to_h)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
end