namespace :csv_load_test do
  task customers: :environment do
    Customer.first
  end
end
