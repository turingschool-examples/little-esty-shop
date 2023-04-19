def test_data
  @customer_1 = Customer.create!(first_name: "John", last_name: "Doe")
  @customer_2 = Customer.create!(first_name: "Jane", last_name: "Doe")
  @customer_3 = Customer.create!(first_name: "Logan", last_name: "Cole")
  @customer_4 = Customer.create!(first_name: "Sally", last_name: "Smith")
  @customer_5 = Customer.create!(first_name: "Sue", last_name: "Smith")
  @customer_6 = Customer.create!(first_name: "Sally", last_name: "Jones")
  @customer_7 = Customer.create!(first_name: "Sue", last_name: "Jones")
  @customer_8 = Customer.create!(first_name: "Sally", last_name: "Williams")
  @customer_9 = Customer.create!(first_name: "Sue", last_name: "Williams")
  @customer_10 = Customer.create!(first_name: "Sally", last_name: "Brown")

  @invoice_1 = Invoice.create!(status: "cancelled", customer: @customer_1)
  @invoice_2 = Invoice.create!(status: "in progress", customer: @customer_2)
  @invoice_3 = Invoice.create!(status: "completed", customer: @customer_3)
  @invoice_4 = Invoice.create!(status: "in progress", customer: @customer_4)
  @invoice_5 = Invoice.create!(status: "in progress", customer: @customer_5)
  @invoice_6 = Invoice.create!(status: "in progress", customer: @customer_6)
  @invoice_7 = Invoice.create!(status: "in progress", customer: @customer_7)
  @invoice_8 = Invoice.create!(status: "completed", customer: @customer_8)
  @invoice_9 = Invoice.create!(status: "completed", customer: @customer_9)
  @invoice_10 = Invoice.create!(status: "completed", customer: @customer_10)

  @merchant_1 = Merchant.create!(name: "Drug Testing Store")
  @merchant_2 = Merchant.create!(name: "Pharmacy By U")
  @merchant_3 = Merchant.create!(name: "Little Pharma")
  @merchant_4 = Merchant.create!(name: "Drugs R US")
  @merchant_5 = Merchant.create!(name: "DARE You To Try This")

  @item_1 = Item.create!(name: "Speed", description: "Description_1", unit_price: 100, merchant: @merchant_1)
  @item_2 = Item.create!(name: "LSD", description: "Description_2", unit_price: 15000, merchant: @merchant_2)
  @item_3 = Item.create!(name: "Cocaine", description: "Description_3", unit_price: 50000, merchant: @merchant_3)
  @item_4 = Item.create!(name: "Heroin", description: "Description_4", unit_price: 20000, merchant: @merchant_4)
  @item_5 = Item.create!(name: "Meth", description: "Description_5", unit_price: 25000, merchant: @merchant_5)
  @item_6 = Item.create!(name: "Crack", description: "Description_6", unit_price: 50000, merchant: @merchant_4)
  @item_7 = Item.create!(name: "Ecstasy", description: "Description_7", unit_price: 10000, merchant: @merchant_3)
  @item_8 = Item.create!(name: "Marijuana", description: "Description_8", unit_price: 100000, merchant: @merchant_5)
  @item_9 = Item.create!(name: "Shrooms", description: "Description_9", unit_price: 56465, merchant: @merchant_1)
  @item_10 = Item.create!(name: "Opium", description: "Description_10", unit_price: 54134, merchant: @merchant_2)

  @invoice_item_1 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: "pending", item: @item_1, invoice: @invoice_1)
  @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 15000, status: "packaged", item: @item_2, invoice: @invoice_2)
  @invoice_item_3 = InvoiceItem.create!(quantity: 10, unit_price: 50000, status: "shipped", item: @item_3, invoice: @invoice_3)
  @invoice_item_4 = InvoiceItem.create!(quantity: 15, unit_price: 20000, status: "pending", item: @item_4, invoice: @invoice_4)
  @invoice_item_5 = InvoiceItem.create!(quantity: 20, unit_price: 25000, status: "packaged", item: @item_5, invoice: @invoice_5)
  @invoice_item_6 = InvoiceItem.create!(quantity: 25, unit_price: 50000, status: "shipped", item: @item_6, invoice: @invoice_6)
  @invoice_item_7 = InvoiceItem.create!(quantity: 30, unit_price: 10000, status: "pending", item: @item_7, invoice: @invoice_7)
  @invoice_item_8 = InvoiceItem.create!(quantity: 35, unit_price: 100000, status: "packaged", item: @item_8, invoice: @invoice_8)
  @invoice_item_9 = InvoiceItem.create!(quantity: 40, unit_price: 56465, status: "shipped", item: @item_9, invoice: @invoice_9)
  @invoice_item_10 = InvoiceItem.create!(quantity: 45, unit_price: 54134, status: "shipped", item: @item_10, invoice: @invoice_10)
  @invoice_item_11 = InvoiceItem.create!(quantity: 50, unit_price: 100, status: "shipped", item: @item_1, invoice: @invoice_2)
  @invoice_item_12 = InvoiceItem.create!(quantity: 55, unit_price: 15000, status: "pending", item: @item_2, invoice: @invoice_3)
  @invoice_item_13 = InvoiceItem.create!(quantity: 60, unit_price: 50000, status: "pending", item: @item_3, invoice: @invoice_4)
  @invoice_item_14 = InvoiceItem.create!(quantity: 65, unit_price: 20000, status: "pending", item: @item_4, invoice: @invoice_5)
  @invoice_item_15 = InvoiceItem.create!(quantity: 70, unit_price: 25000, status: "shipped", item: @item_5, invoice: @invoice_6)
  @invoice_item_16 = InvoiceItem.create!(quantity: 75, unit_price: 50000, status: "packaged", item: @item_6, invoice: @invoice_7)
  @invoice_item_17 = InvoiceItem.create!(quantity: 80, unit_price: 10000, status: "packaged", item: @item_7, invoice: @invoice_8)
  @invoice_item_18 = InvoiceItem.create!(quantity: 85, unit_price: 100000, status: "packaged", item: @item_8, invoice: @invoice_9)
  @invoice_item_19 = InvoiceItem.create!(quantity: 90, unit_price: 56465, status: "shipped", item: @item_9, invoice: @invoice_10)
  @invoice_item_20 = InvoiceItem.create!(quantity: 95, unit_price: 54134, status: "shipped", item: @item_10, invoice: @invoice_1)
  
  @transaction_1 = Transaction.create!(credit_card_number: "1234567890145446", credit_card_expiration_date: "2024-03-06", result: 1, invoice: @invoice_1)
  @transaction_2 = Transaction.create!(credit_card_number: "1234567890123456", credit_card_expiration_date: "2025-01-01", result: 1, invoice: @invoice_2)
  @transaction_3 = Transaction.create!(credit_card_number: "1234146541543155", credit_card_expiration_date: "2025-01-11", result: 0, invoice: @invoice_3)
  @transaction_4 = Transaction.create!(credit_card_number: "1234567890123456", credit_card_expiration_date: "2025-01-01", result: 0, invoice: @invoice_4)
  @transaction_5 = Transaction.create!(credit_card_number: "1234146541543155", credit_card_expiration_date: "2025-01-11", result: 0, invoice: @invoice_5)
  @transaction_6 = Transaction.create!(credit_card_number: "1234567890123456", credit_card_expiration_date: "2025-01-01", result: 0, invoice: @invoice_6)
  @transaction_7 = Transaction.create!(credit_card_number: "1234146541543155", credit_card_expiration_date: "2025-01-11", result: 1, invoice: @invoice_7)
  @transaction_8 = Transaction.create!(credit_card_number: "1234567890123456", credit_card_expiration_date: "2025-01-01", result: 1, invoice: @invoice_8)
  @transaction_9 = Transaction.create!(credit_card_number: "1234146541543155", credit_card_expiration_date: "2025-01-11", result: 0, invoice: @invoice_9)
  @transaction_10 = Transaction.create!(credit_card_number: "1234567890123456", credit_card_expiration_date: "2025-01-01", result: 1, invoice: @invoice_10)
end


# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start
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
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end
