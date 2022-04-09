desc 'Say hello!'
namespace :csv_load do

  task :customers do
    require 'csv'
    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # puts row.to_hash
      c = Customer.new
      c.id = row[:id]
      c.first_name = row[:first_name]
      c.last_name = row[:last_name]
      c.created_at = row[:created_at]
      c.updated_at = row[:updated_at]
      c.save
      puts "#{c.first_name} #{c.last_name} saved"
    end
  end

  # task :transactions do
  #   require 'csv'
  #   csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each do |row|
  #     c = Customer.new
  #     c.id = row[:id]
  #     c.first_name = row[:first_name]
  #     c.last_name = row[:last_name]
  #     c.created_at = row[:created_at]
  #     c.updated_at = row[:updated_at]
  #     c.save
  #     puts "#{c.first_name} #{c.last_name} saved"
  #   end
  # end

  task :all do
    system("rake csv_load:customers")
    # :trand
  end

end
