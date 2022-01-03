require 'csv'

desc "Import customers from csv"
task :import => [:environment] do

  file = "db/data/customers.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      first_name = row[1],
      last_name = row[2],
      created_at = row[3],
      updated_at = row[4]

      Customer.create!(id: id,
                      first_name: first_name,
                      last_name: last_name,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
end
