namespace :csv_load do 
  task :all => [:customers, :merchants] do
  # Rake::Task['customers'].invoke
  # Rake::Task['merchants'].invoke
  end
end
