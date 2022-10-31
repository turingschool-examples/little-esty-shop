namespace :csv_load do

  task :customers do
    csv_text = File.read("db/data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      db.execute("INSERT INTO customers (
      first_name,
      last_name,
      created_at,
      updated_at
      ) VALUES(?, ?, ?, ?)",
      row["first_name"], row["last_name"], row["created_at"], row["updated_at"]
      )
    end
  end
end

# Your project will include a Rake task for each of the six csv files
# rails csv_load:customers
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions