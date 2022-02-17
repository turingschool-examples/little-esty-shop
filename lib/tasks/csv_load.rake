require 'csv'

namespace :csv_load do 
  desc 'run all'
  task all: [:customers, :invoices]

  desc 'Load customer data'
  task customers: :environment do
    file_path = './db/data/customers.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Customer.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load merchants data'
  task merchants: :environment do
    file_path = './db/data/merchants.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Merchant.find_or_create_by!(line.to_hash)
    end
  end

  # desc 'Load customer data'
  # task customers: :environment do
  #   file_path = './db/data/customers.csv'
  #   data = CSV.read(file_path, headers: true, header_converters: :symbol)

  #   data.each do |line|
  #     Customer.find_or_create_by!(line.to_hash)
  #   end
  # end
end
