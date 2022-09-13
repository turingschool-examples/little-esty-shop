
# require '././app/models/application_record'
require 'csv'  

desc "I am short, but comprehensive description for my cool task"
# task :setuper do
  # rails csv_load:customers (from instructions)
  # All your magic here
  # Any valid Ruby code is allowed

  # csv_text = File.read('db/data/customers.csv')
  # csv = CSV.parse(csv_text, :headers => true)
  # csv.each do |row|
  #   Customer.create!(row.to_hash)

      namespace :csv_load do
      task :customers => :environment do
        csv_text = File.read('db/data/customers.csv')
        csv = CSV.parse(csv_text, :headers => true)
        csv.each do |row|
          Customer.create!(row.to_hash)
      end
    end

  end
  # puts "Hello"
# end