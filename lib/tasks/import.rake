require 'csv'

desc "Import merchants from csv file"
task :csv_load, [:path] => [:environment] do |task, args|
  
  file = "db/data/#{args.path}.csv"

  CSV.foreach(file, :headers => true) do |row|
    Merchant.create(row.to_hash)
  end
end