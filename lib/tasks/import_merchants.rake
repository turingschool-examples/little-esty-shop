require 'csv'

desc 'Import merchants from csv'
task :import_merchants_csv => [:environment] do

  file = "db/data/merchants.csv"

  CSV.foreach(file, :headers => true) do |row|
    id = row[0],
    name = row[1],
    created_at = row[2],
    updated_at = row[3]

    Merchant.create!(id: id,
                    name: name,
                    created_at: created_at,
                    updated_at: updated_at,
                    status: 0)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
end
