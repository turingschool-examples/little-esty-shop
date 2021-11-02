require 'csv'

desc 'seed customers.csv'
task "csv_load:customers" => :environment do
  csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
  csv = CSV.parse(csv_text, headers: true)
  csv.each do |row|
    c = Customer.new
    c.id = row['id']
    c.first_name = row['first_name']
    c.last_name = row['last_name']
    c.created_at = row['created_at']
    c.updated_at = row['updated_at']
    c.save
    puts "Customer #{c.id} saved!"
  end
  table = "customers"
  auto_inc_value = Customer.order(id: :desc).first.id + 1
  ActiveRecord::Base.connection.execute(
    "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_value};"
  )

  puts "There are now #{Customer.count} rows in the customers table"
end