require 'simplecov'
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include FactoryBot::Syntax::Methods
  config.before(:each) do

    @merch_1 = create(:merchant)
    @merch_2 = create(:merchant)
    @merch_3 = create(:merchant)
  
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
  
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
    @invoice_6 = create(:invoice)

    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
    @item_4 = create(:item)
    @item_5 = create(:item)
    @item_6 = create(:item)
  
    @invoice_item_2 = create(:invoice_item)
    @invoice_item_3 = create(:invoice_item)
    @invoice_item_4 = create(:invoice_item)
    @invoice_item_5 = create(:invoice_item)
    @invoice_item_6 = create(:invoice_item)
    @invoice_item_1 = create(:invoice_item)
    @invoice_item_7 = create(:invoice_item)
    @invoice_item_8 = create(:invoice_item)
    @invoice_item_9 = create(:invoice_item)
    @invoice_item_10 = create(:invoice_item)
    @invoice_item_11 = create(:invoice_item)
    @invoice_item_12 = create(:invoice_item)
    @invoice_item_13 = create(:invoice_item)
    @invoice_item_14 = create(:invoice_item)
    @invoice_item_15 = create(:invoice_item)
    @invoice_item_16 = create(:invoice_item)
    @invoice_item_17 = create(:invoice_item)
    @invoice_item_18 = create(:invoice_item)
    @invoice_item_19 = create(:invoice_item)
    @invoice_item_20 = create(:invoice_item)
    @invoice_item_21 = create(:invoice_item)
    @invoice_item_22 = create(:invoice_item)
  
    @trans_1 = create(:transaction)
    @trans_2 = create(:transaction)
    @trans_3 = create(:transaction)
    @trans_4 = create(:transaction)
    @trans_5 = create(:transaction)
    @trans_6 = create(:transaction)
    @trans_7 = create(:transaction)
    @trans_8 = create(:transaction)
    @trans_9 = create(:transaction)
    @trans_10 = create(:transaction)
    @trans_11 = create(:transaction)
    @trans_12 = create(:transaction)
    @trans_13 = create(:transaction)
    @trans_14 = create(:transaction)
    @trans_15 = create(:transaction)
    @trans_16 = create(:transaction)
    @trans_17 = create(:transaction)
    @trans_18 = create(:transaction)
    @trans_19 = create(:transaction)
    @trans_20 = create(:transaction)
    @trans_21 = create(:transaction)
    @trans_22 = create(:transaction)
  
  end
  # for FactoryBot
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end