require 'csv'
namespace :csv_load do 
    desc "Create all customers"
    task :customers => [:environment] do 
        path = './db/data/customers.csv'

        CSV.foreach(path, :headers => true) do |row|
            id = row[0],
            first_name = row[1],
            last_name = row[2],
            created_at = row[3],
            updated_at = row[4],
            invoice_id = row[5]
            Customer.create!(id: id,
                            first_name: first_name,
                            last_name: last_name,
                            created_at: created_at,
                            updated_at: updated_at,
                            invoice_id: invoice_id)
        end
        ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    end
end 


# rails csv_load:customers
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions