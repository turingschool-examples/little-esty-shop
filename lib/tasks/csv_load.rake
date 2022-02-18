namespace :csv_load do
  desc "load transaction csv"
  task transaction_load: :environment do
  end

  desc "load item csv"
  task item_load: :environment do
  end

  desc "load merchant csv"
  task merchant_load: :environment do
  end

  desc "load invoice_items csv"
  task invoice_items_load: :environment do
  end

  desc "load customer csv"
  task customer_load: :environment do
  end

  desc "load invoice csv"
  task invoice_load: :environment do
  end

  desc "import all csv"
  task all: :environment do
  end

end
