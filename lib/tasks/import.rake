require 'csv'

desc "Imports given class's csv file"
task :csv_load, [:class] => [:environment] do |task, args|
  file = "db/data/#{args.class}s.csv"

  CSV.foreach(file, :headers => true) do |row|
    args.path.capitalize.constantize.create(row.to_hash)
  end
end
