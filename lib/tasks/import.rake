require 'csv'

desc "Imports given class's csv file"
task :csv_load, [:path] => [:environment] do |task, args|
  file = "db/data/#{args.path}s.csv"
  # binding.pry
  CSV.foreach(file, :headers => true) do |row|
    args.path.capitalize.constantize.create!(row.to_hash)
  end
end

desc "Imports all csv files into the database"
task :csv_load_all => [:environment] do
  table_names = ['merchant', 'customer', 'item', 'invoice', 'transaction', 'invoiceItem']

  table_names.each do |name|
    Rake::Task["csv_load"].invoke(name)
    Rake::Task["csv_load"].reenable
  end
end
