namespace :csv_load do
  desc "Create seed files for all CSV"
  task :all => :environment do
    Rake::Task[:customers].invoke
    Rake::Task[:invoice_items].invoke
    Rake::Task[:invoices].invoke
    Rake::Task[:items].invoke
    Rake::Task[:merchants].invoke
    Rake::Task[:transactions].invoke
  end
end
