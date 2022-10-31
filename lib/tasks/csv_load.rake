require 'csv'

namespace :csv_load do
  task :customers do 
    csv = CSV.open('./db/data/customers')
    csv.each do |row|

    end
  end
end
