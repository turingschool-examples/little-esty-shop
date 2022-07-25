# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

Rails.application.load_tasks

namespace :csv_load do
  
  desc 'Seed Merchant Table!'
  task :merchants => :environment do
    csv_text = File.read("db/data/merchants.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      m = Merchant.new
      m.name = row['name']
      m.created_at = row['created_at']
      m.updated_at = row['updated_at']
      m.save
      puts "#{m.name} is created"
    end
  end
end