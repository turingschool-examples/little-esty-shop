require 'csv'

namespace :csv_load do

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    table = 'merchants'
    auto_inc_val = 101
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end
end

# require 'csv'

# namespace :customers do
#   desc "Import customers from a CSV file"
#   task :import_csv => :environment do
#
#     file = 'db/data/customers.csv'
#
#     CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
#       Customer.create!(row.to_hash)
#     end
#   end
#   ActiveRecord::Base.connection.reset_pk_sequence!('customers')
# end




# namespace :customers do
#   desc "Import customers from csv"
#   task :import_csv => [:environment] do
#
#   file = "db/data/customers.csv"
#
#     CSV.foreach(file, :headers => true) do |row|
#
#         id = row[0],
#         first_name = row[1],
#         last_name = row[2],
#         created_at = row[3],
#         updated_at = row[4]
#
#         Customer.create!(id: id,
#                         first_name: first_name,
#                         last_name: last_name,
#                         created_at: created_at,
#                         updated_at: updated_at)
#
#     end
#
#   end
# end

# namespace :db do
#
#   namespace :seed do
#
#     desc "Create CSV Files for Models"
#     task :create_files => :environment do
#       Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }
#       dir = "#{Rails.root}/db/csv"
#       FileUtils.mkdir(dir) unless Dir.exists?(dir)
#       ActiveRecord::Base.descendants.each do |model|
#         unless File.exists?("#{dir}/#{model.to_s.tableize}.csv")
#           File.open("#{dir}/#{model.to_s.tableize}.csv", 'w+') do |f|
#             f.write(model.columns.collect(&:name).join(','))
#           end
#           puts "CREATED FILE >> #{model.to_s.tableize}.csv"
#         end
#       end
#     end
#
#   end
#
# end
