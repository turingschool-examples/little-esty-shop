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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Invoice.destroy_all
    Customer.destroy_all
    Item.destroy_all
    Merchant.destroy_all

    @merchant_1 = Merchant.create!(name: "Frank")
    # Items
    @item_1 = @merchant_1.items.create!(name: "Item_1", description: "Description_1", unit_price: 16)
    @item_2 = @merchant_1.items.create!(name: "Item_2", description: "Description_2", unit_price: 23)
    @item_3 = @merchant_1.items.create!(name: "Item_3", description: "Description_3", unit_price: 11)
    @item_4 = @merchant_1.items.create!(name: "Item_4", description: "Description_4", unit_price: 312)
    @item_5 = @merchant_1.items.create!(name: "Item_5", description: "Description_5", unit_price: 23)
    @item_6 = @merchant_1.items.create!(name: "Item_6", description: "Description_6", unit_price: 41)
    @item_7 = @merchant_1.items.create!(name: "Item_7", description: "Description_7", unit_price: 153)
    @item_8 = @merchant_1.items.create!(name: "Item_8", description: "Description_8", unit_price: 1)
    @item_9 = @merchant_1.items.create!(name: "Item_9", description: "Description_9", unit_price: 15)
    @item_10 = @merchant_1.items.create!(name: "Item_10", description: "Description_10", unit_price: 87)
    #customer
    @customer_1 = Customer.create!(first_name: "Customer", last_name: "1")
    @customer_2 = Customer.create!(first_name: "ACustomer", last_name: "2")
    @customer_3 = Customer.create!(first_name: "BCustomer", last_name: "3")
    @customer_4 = Customer.create!(first_name: "CCustomer", last_name: "4")
    @customer_5 = Customer.create!(first_name: "DCustomer", last_name: "5")
    @customer_6 = Customer.create!(first_name: "ECustomer", last_name: "6")
    #invoices
    @invoice_1 = @customer_1.invoices.create!
    @invoice_2 = @customer_1.invoices.create!
    @invoice_3 = @customer_1.invoices.create!
    @invoice_4 = @customer_2.invoices.create!
    @invoice_5 = @customer_2.invoices.create!
    @invoice_6 = @customer_3.invoices.create!
    @invoice_7 = @customer_4.invoices.create!
    @invoice_8 = @customer_4.invoices.create!
    @invoice_9 = @customer_4.invoices.create!
    @invoice_10 = @customer_4.invoices.create!
    @invoice_11 = @customer_5.invoices.create!
    @invoice_12 = @customer_5.invoices.create!
    @invoice_13 = @customer_6.invoices.create!
    @invoice_14 = @customer_6.invoices.create!
    @invoice_15 = @customer_6.invoices.create!
    @invoice_16 = @customer_6.invoices.create!
    @invoice_17 = @customer_6.invoices.create!
    @invoice_18 = @customer_6.invoices.create!
    #invoice items
    @invoice_1.invoice_items.create!(item_id: @item_1.id, quantity: 1, unit_price: @item_1.unit_price)
    @invoice_2.invoice_items.create!(item_id: @item_2.id, quantity: 1, unit_price: @item_2.unit_price)
    @invoice_3.invoice_items.create!(item_id: @item_3.id, quantity: 1, unit_price: @item_3.unit_price)
    @invoice_4.invoice_items.create!(item_id: @item_4.id, quantity: 1, unit_price: @item_4.unit_price)
    @invoice_5.invoice_items.create!(item_id: @item_5.id, quantity: 1, unit_price: @item_5.unit_price)
    @invoice_6.invoice_items.create!(item_id: @item_6.id, quantity: 1, unit_price: @item_6.unit_price)
    @invoice_7.invoice_items.create!(item_id: @item_7.id, quantity: 1, unit_price: @item_7.unit_price)
    @invoice_8.invoice_items.create!(item_id: @item_8.id, quantity: 1, unit_price: @item_8.unit_price)
    @invoice_9.invoice_items.create!(item_id: @item_9.id, quantity: 1, unit_price: @item_9.unit_price)
    @invoice_10.invoice_items.create!(item_id: @item_10.id, quantity: 1, unit_price: @item_10.unit_price)
    @invoice_11.invoice_items.create!(item_id: @item_1.id, quantity: 1, unit_price: @item_1.unit_price)
    @invoice_12.invoice_items.create!(item_id: @item_1.id, quantity: 1, unit_price: @item_1.unit_price)
    @invoice_13.invoice_items.create!(item_id: @item_2.id, quantity: 1, unit_price: @item_2.unit_price)
    @invoice_14.invoice_items.create!(item_id: @item_7.id, quantity: 1, unit_price: @item_7.unit_price)
    @invoice_15.invoice_items.create!(item_id: @item_8.id, quantity: 1, unit_price: @item_8.unit_price)
    @invoice_16.invoice_items.create!(item_id: @item_9.id, quantity: 1, unit_price: @item_9.unit_price)
    @invoice_17.invoice_items.create!(item_id: @item_2.id, quantity: 1, unit_price: @item_2.unit_price)
    @invoice_18.invoice_items.create!(item_id: @item_3.id, quantity: 1, unit_price: @item_3.unit_price)
    #transaction
    @invoice_1.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_2.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_3.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_4.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_5.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_6.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_7.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_8.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_9.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_10.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_11.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_12.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_13.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_14.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_15.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_16.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_17.transactions.create!(credit_card_number: "1", result: "success")
    @invoice_18.transactions.create!(credit_card_number: "1", result: "success")
  end

  config.after(:each) do
    FactoryBot.reload
  end
  config.include FactoryBot::Syntax::Methods
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
