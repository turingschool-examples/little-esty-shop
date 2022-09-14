namespace :test_db do
  desc "Setup test database - drops, loads schema, migrates and seeds the test db"
  task setup: :environment do
    Rails.env = ENV['RAILS_ENV'] = 'test'
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['csv_load_mock:all'].invoke
  end
end