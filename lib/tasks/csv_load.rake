require "csv"

namespace :csv_load do

  task customers: :environment do
    from_csv(Customer,"db/data/customers.csv")
  end

  task merchants: :environment do
    from_csv(Merchant,"db/data/merchants.csv")
  end

  task items: :environment do
    from_csv(Item,"db/data/items.csv")
  end

  task invoices: :environment do
    from_csv(Invoice,"db/data/invoices.csv")
  end

  task invoice_items: :environment do
    from_csv(InvoiceItem,"db/data/invoice_items.csv")
  end

  task transactions: :environment do
    from_csv(Transaction,"db/data/transactions.csv")
  end

  task all: [
    :customers, :merchants, :items, :invoices, :invoice_items, :transactions
  ]
end


def from_csv(model,path)
  CSV.foreach(path, headers: true) do |row|
    model.create(row.to_h)
  end
end
