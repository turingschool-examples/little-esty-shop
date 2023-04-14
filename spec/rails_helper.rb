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

  # for FactoryBot
  config.include FactoryBot::Syntax::Methods

  # test data
#   config.before(:each) do
#     @merch_1 = create(:merchant)
#     @merch_2 = create(:merchant)
#     @merch_3 = create(:merchant)

#     @cust_1 = create(:customer)
#     @cust_2 = create(:customer)
#     @cust_3 = create(:customer)
#     @cust_4 = create(:customer)
#     @cust_5 = create(:customer)
#     @cust_6 = create(:customer)

#     @invoice_1 = create(:invoice, customer: @cust_1)
#     @invoice_2 = create(:invoice, customer: @cust_1)
#     @invoice_3 = create(:invoice, customer: @cust_1)
#     @invoice_4 = create(:invoice, customer: @cust_1)
#     @invoice_5 = create(:invoice, customer: @cust_1)
#     @invoice_6 = create(:invoice, customer: @cust_1)
#     @invoice_7 = create(:invoice, customer: @cust_2)
#     @invoice_8 = create(:invoice, customer: @cust_2)
#     @invoice_9 = create(:invoice, customer: @cust_2)
#     @invoice_10 = create(:invoice, customer: @cust_2)
#     @invoice_11 = create(:invoice, customer: @cust_2)
#     @invoice_12 = create(:invoice, customer: @cust_3)
#     @invoice_13 = create(:invoice, customer: @cust_3)
#     @invoice_14 = create(:invoice, customer: @cust_3)
#     @invoice_15 = create(:invoice, customer: @cust_3)
#     @invoice_16 = create(:invoice, customer: @cust_4)
#     @invoice_17= create(:invoice, customer: @cust_4)
#     @invoice_18 = create(:invoice, customer: @cust_4)
#     @invoice_19 = create(:invoice, customer: @cust_5)
#     @invoice_20= create(:invoice, customer: @cust_5)
#     @invoice_21 = create(:invoice, customer: @cust_6)

#     @item_1 = create(:item, merchant: @merch_1)
#     @item_2 = create(:item, merchant: @merch_1)
#     @item_3 = create(:item, merchant: @merch_2)
#     @item_4 = create(:item, merchant: @merch_2)
#     @item_5 = create(:item, merchant: @merch_2)
#     @item_6 = create(:item, merchant: @merch_3)
#     @item_7 = create(:item, merchant: @merch_3)
#     @item_8 = create(:item, merchant: @merch_3)
#     @item_9 = create(:item, merchant: @merch_3)
#     @item_10 = create(:item, merchant: @merch_3)

#     @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
#     @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2)
#     @invoice_item_3 = create(:invoice_item, invoice: @invoice_1, item: @item_7)
#     @invoice_item_4 = create(:invoice_item, invoice: @invoice_1, item: @item_9)
#     @invoice_item_5 = create(:invoice_item, invoice: @invoice_2, item: @item_9)
#     @invoice_item_6 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
#     @invoice_item_7 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
#     @invoice_item_8 = create(:invoice_item, invoice: @invoice_3, item: @item_5)
#     @invoice_item_9 = create(:invoice_item, invoice: @invoice_3, item: @item_10)
#     @invoice_item_10 = create(:invoice_item, invoice: @invoice_3, item: @item_9)
#     @invoice_item_11 = create(:invoice_item, invoice: @invoice_4, item: @item_1)
#     @invoice_item_12 = create(:invoice_item, invoice: @invoice_4, item: @item_2)
#     @invoice_item_13 = create(:invoice_item, invoice: @invoice_4, item: @item_10)
#     @invoice_item_14 = create(:invoice_item, invoice: @invoice_4, item: @item_9)
#     @invoice_item_15 = create(:invoice_item, invoice: @invoice_4, item: @item_3)
#     @invoice_item_16 = create(:invoice_item, invoice: @invoice_5, item: @item_3)
#     @invoice_item_17 = create(:invoice_item, invoice: @invoice_5, item: @item_6)
#     @invoice_item_18 = create(:invoice_item, invoice: @invoice_5, item: @item_4)
#     @invoice_item_19 = create(:invoice_item, invoice: @invoice_6, item: @item_1)
#     @invoice_item_20 = create(:invoice_item, invoice: @invoice_6, item: @item_2)
#     @invoice_item_21 = create(:invoice_item, invoice: @invoice_6, item: @item_9)
#     @invoice_item_22 = create(:invoice_item, invoice: @invoice_6, item: @item_4)
#     @invoice_item_23 = create(:invoice_item, invoice: @invoice_1, item: @item_7)
#     @invoice_item_24 = create(:invoice_item, invoice: @invoice_2, item: @item_8)
#     @invoice_item_25 = create(:invoice_item, invoice: @invoice_2, item: @item_5)
#     @invoice_item_26 = create(:invoice_item, invoice: @invoice_3, item: @item_10)
#     @invoice_item_27 = create(:invoice_item, invoice: @invoice_4, item: @item_7)
#     @invoice_item_28 = create(:invoice_item, invoice: @invoice_5, item: @item_7)
#     @invoice_item_29 = create(:invoice_item, invoice: @invoice_6, item: @item_8)
#     @invoice_item_30 = create(:invoice_item, invoice: @invoice_6, item: @item_10)

#     @trans_1 = create(:transaction, result: 1, invoice: @invoice_1)
#     @trans_2 = create(:transaction, result: 1, invoice: @invoice_2)
#     @trans_3 = create(:transaction, result: 1, invoice: @invoice_3)
#     @trans_4 = create(:transaction, result: 1, invoice: @invoice_4)
#     @trans_5 = create(:transaction, result: 1, invoice: @invoice_5)
#     @trans_6 = create(:transaction, result: 1, invoice: @invoice_6)
#     @trans_7 = create(:transaction, result: 1, invoice: @invoice_6)
#     @trans_8 = create(:transaction, result: 1, invoice: @invoice_8)
#     @trans_9 = create(:transaction, result: 1, invoice: @invoice_9)
#     @trans_10 = create(:transaction, result: 1, invoice: @invoice_10)
#     @trans_11 = create(:transaction, result: 1, invoice: @invoice_11)
#     @trans_12 = create(:transaction, result: 1, invoice: @invoice_12)
#     @trans_13 = create(:transaction, result: 1, invoice: @invoice_13)
#     @trans_14 = create(:transaction, result: 1, invoice: @invoice_14)
#     @trans_15 = create(:transaction, result: 1, invoice: @invoice_15)
#     @trans_16 = create(:transaction, result: 1, invoice: @invoice_16)
#     @trans_17 = create(:transaction, result: 1, invoice: @invoice_17)
#     @trans_18 = create(:transaction, result: 1, invoice: @invoice_18)
#     @trans_19 = create(:transaction, result: 1, invoice: @invoice_19)
#     @trans_20 = create(:transaction, result: 0, invoice: @invoice_20)
#     @trans_21 = create(:transaction, result: 1, invoice: @invoice_20)
#     @trans_22 = create(:transaction, result: 1, invoice: @invoice_21)
#   end
# end

  def us_3_test_data
    @merch_1 = create(:merchant)
    @merch_2 = create(:merchant)

    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    @cust_7 = create(:customer)

    @item_1 = create(:item, merchant: @merch_1)
    @item_2 = create(:item, merchant: @merch_2)

    # customer 6 - 6 succ transactions
    # switching cust 6 and 1 to make sure method is able to order on its own
    6.times do
      invoice = create(:invoice, status: 1, customer: @cust_6)
      create(:invoice_item, invoice: invoice, item: @item_1)
      create(:transaction, result: 1, invoice: invoice)
    end

    invoice = create(:invoice, status: 1, customer: @cust_6)
      create(:invoice_item, invoice: invoice, item: @item_2)
      create(:transaction, result: 1, invoice: invoice)

    # customer 2 - 5 succ transactions
    5.times do
      invoice = create(:invoice, status: 1, customer: @cust_2)
      create(:invoice_item, invoice: invoice, item: @item_1)
      create(:transaction, result: 1, invoice: invoice)
    end

    # customer 3 - 4 succ transactions
    4.times do
      invoice = create(:invoice, status: 1, customer: @cust_3)
      create(:invoice_item, invoice: invoice, item: @item_1)
      create(:transaction, result: 1, invoice: invoice)
    end

    # customer 4 - 3 succ transactions
    3.times do
      invoice = create(:invoice, status: 1, customer: @cust_4)
      create(:invoice_item, invoice: invoice, item: @item_1)
      create(:transaction, result: 1, invoice: invoice)
    end
    
    # customer 5 - 2 success 2 failures
    2.times do 
      invoice = create(:invoice, status: 1, customer: @cust_5)
      create(:invoice_item, invoice: invoice, item: @item_1)
      create(:transaction, result: 0, invoice: invoice)
      create(:transaction, result: 1, invoice: invoice)
    end

    # customer 1 - one succ transaction
    invoice = create(:invoice, status: 1, customer: @cust_1)
    create(:invoice_item, invoice: invoice, item: @item_1)
    create(:transaction, result: 1, invoice: invoice)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end