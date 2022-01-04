namespace :csv_load do
  task :all => [:customers, :merchants, :items] do
  # Rake::Task['customers'].invoke
  # Rake::Task['merchants'].invoke
  # Rake::Task['items'].invoke
  end
end
