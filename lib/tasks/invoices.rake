namespace :csv_load do
  task invoices: :environment do
    Invoice.destroy_all
    csv.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end
end
