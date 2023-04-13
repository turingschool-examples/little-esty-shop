# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter "spec/rails_helper.rb"
end

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
  config.include FactoryBot::Syntax::Methods
  # config.before(:each) do
  #   @merchant_1 = create(:merchant)
  #   @merchant_2 = create(:merchant)
  #   @merchant_3 = create(:merchant)
  #   @merchant_4 = create(:merchant)
  #   @merchant_5 = create(:merchant)

  #   @item_1 = create(:item, merchant_id: @merchant_1.id)
  #   @item_2 = create(:item, merchant_id: @merchant_1.id)
  #   @item_3 = create(:item, merchant_id: @merchant_2.id)
  #   @item_4 = create(:item, merchant_id: @merchant_2.id)
  #   @item_5 = create(:item, merchant_id: @merchant_3.id)
  #   @item_6 = create(:item, merchant_id: @merchant_3.id)
  #   @item_7 = create(:item, merchant_id: @merchant_4.id)
  #   @item_8 = create(:item, merchant_id: @merchant_4.id)
  #   @item_9 = create(:item, merchant_id: @merchant_5.id)
  #   @item_10 = create(:item, merchant_id: @merchant_5.id)

  #   @customer_1 = create(:customer)
  #   @customer_2 = create(:customer)
  #   @customer_3 = create(:customer)
  #   @customer_4 = create(:customer)
  #   @customer_5 = create(:customer)

  #   @invoice_1 = create(:invoice, customer_id: @customer_1.id)
  #   @invoice_2 = create(:invoice, customer_id: @customer_1.id)
  #   @invoice_3 = create(:invoice, customer_id: @customer_2.id)
  #   @invoice_4 = create(:invoice, customer_id: @customer_2.id)
  #   @invoice_5 = create(:invoice, customer_id: @customer_3.id)
  #   @invoice_6 = create(:invoice, customer_id: @customer_3.id)
  #   @invoice_7 = create(:invoice, customer_id: @customer_4.id)
  #   @invoice_8 = create(:invoice, customer_id: @customer_4.id)
  #   @invoice_9 = create(:invoice, customer_id: @customer_5.id)
  #   @invoice_10 = create(:invoice, customer_id: @customer_5.id)

  #   @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
  #   @transaction_2 = create(:transaction, invoice_id: @invoice_1.id)
  #   @transaction_3 = create(:transaction, invoice_id: @invoice_2.id)
  #   @transaction_4 = create(:transaction, invoice_id: @invoice_2.id)
  #   @transaction_5 = create(:transaction, invoice_id: @invoice_3.id)
  #   @transaction_6 = create(:transaction, invoice_id: @invoice_3.id)
  #   @transaction_7 = create(:transaction, invoice_id: @invoice_4.id)
  #   @transaction_8 = create(:transaction, invoice_id: @invoice_4.id)
  #   @transaction_9 = create(:transaction, invoice_id: @invoice_5.id)
  #   @transaction_10 = create(:transaction, invoice_id: @invoice_5.id)
  #   @transaction_11 = create(:transaction, invoice_id: @invoice_6.id)
  #   @transaction_12 = create(:transaction, invoice_id: @invoice_6.id)
  #   @transaction_13 = create(:transaction, invoice_id: @invoice_7.id)
  #   @transaction_14 = create(:transaction, invoice_id: @invoice_7.id)
  #   @transaction_15 = create(:transaction, invoice_id: @invoice_8.id)
  #   @transaction_16 = create(:transaction, invoice_id: @invoice_8.id)
  #   @transaction_17 = create(:transaction, invoice_id: @invoice_9.id)
  #   @transaction_18 = create(:transaction, invoice_id: @invoice_9.id)
  #   @transaction_19 = create(:transaction, invoice_id: @invoice_10.id)
  #   @transaction_20 = create(:transaction, invoice_id: @invoice_10.id)

  #   @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
  #   @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
  #   @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id)
  #   @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_3.id)
  #   @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_3.id)
  #   @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_4.id)
  #   @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_4.id)
  #   @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_5.id)
  #   @invoice_item_9 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id)
  #   @invoice_item_10 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_6.id)
  #   @invoice_item_11 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_6.id)
  #   @invoice_item_12 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_7.id)
  #   @invoice_item_13 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: @item_7.id)
  #   @invoice_item_14 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: @item_8.id)
  #   @invoice_item_15 = create(:invoice_item, invoice_id: @invoice_8.id, item_id: @item_8.id)
  #   @invoice_item_16 = create(:invoice_item, invoice_id: @invoice_8.id, item_id: @item_9.id)
  #   @invoice_item_17 = create(:invoice_item, invoice_id: @invoice_9.id, item_id: @item_9.id)
  #   @invoice_item_18 = create(:invoice_item, invoice_id: @invoice_9.id, item_id: @item_10.id)
  #   @invoice_item_19 = create(:invoice_item, invoice_id: @invoice_10.id, item_id: @item_10.id)
  #   @invoice_item_20 = create(:invoice_item, invoice_id: @invoice_10.id, item_id: @item_1.id)
  # end
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

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end