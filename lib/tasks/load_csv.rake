desc "I am short, but comprehensive description for my cool task"
task load_customers: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/customer.rb'
  Customer.connection
  # CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
  #   Customer.new(row)
  # end
  # csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
  # csv = CSV.foreach(csv_text, :headers => true,  header_converters: :symbol, :encoding => 'UTF-8')
  # csv.foreach do |row|
  CSV.foreach('./db/data/customers.csv', :headers => true,  header_converters: :symbol, :encoding => 'UTF-8') do |row|
    require 'pry'; binding.pry
    t = Customer.new
    t.first_name = row[:first_name]
    t.last_name = row[:last_name]
    t.save
  end
end