desc "Load all CSVs"
task :csv_load_all => [
  'csv_load:customers',
  'csv_load:invoices',
  'csv_load:merchants',
  'csv_load:items',
  'csv_load:transactions',
  'csv_load:invoice_items'
]