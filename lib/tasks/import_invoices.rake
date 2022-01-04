require 'csv'

desc "Import invoices from csv"
task :import_invoices_csv => [:environment] do
  file = "db/data/invoices.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      customer_id = row[1],
      status = row[2],
      created_at = row[3],
      updated_at = row[4]

      Invoice.create!(id: id,
                      customer_id: customer_id,
                      status: status,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
end
