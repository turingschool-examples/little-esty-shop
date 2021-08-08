# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start
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
  config.before(:each) do
    Transaction.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all

    #Merchants
    @merchant1 = Merchant.create!(name: 'Costco', status: "disabled")
    @merchant2 = Merchant.create!(name: 'Target', status: "disabled")
    @merchant3 = Merchant.create!(name: 'Walmart', status: "disabled")
    @merchant4 = Merchant.create!(name: 'Kroger', status: "disabled")
    @merchant5 = Merchant.create!(name: 'Amazon', status: "enabled")
    @merchant6 = Merchant.create!(name: 'Ebay', status: "enabled")
    @merchant7 = Merchant.create!(name: 'HomeDepot', status: "disabled")

    #Bulk Discounts
    @bulk_discount1 = BulkDiscount.create!(percentage_discount: 0.2, quantity_threshold: 20, merchant_id: @merchant1.id)
    @bulk_discount2 = BulkDiscount.create!(percentage_discount: 0.3, quantity_threshold: 30, merchant_id: @merchant1.id)
    @bulk_discount3 = BulkDiscount.create!(percentage_discount: 0.2, quantity_threshold: 20, merchant_id: @merchant3.id)
    @bulk_discount4 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 40, merchant_id: @merchant1.id)
    @bulk_discount5 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 25, merchant_id: @merchant2.id)
    @bulk_discount6 = BulkDiscount.create!(percentage_discount: 0.1, quantity_threshold: 10, merchant_id: @merchant1.id)

    #Customers
    @customer1 = Customer.create!(first_name: 'Gunner', last_name: 'Runkle')
    @customer2 = Customer.create!(first_name: 'Antonio', last_name: 'King')
    @customer3 = Customer.create!(first_name: 'Jacob', last_name: 'Martinez')
    @customer4 = Customer.create!(first_name: 'Lee', last_name: 'Hopper')
    @customer5 = Customer.create!(first_name: 'Angelina', last_name: 'Jolie')
    @customer6 = Customer.create!(first_name: 'Brad', last_name: 'Pitt')
    @customer7 = Customer.create!(first_name: 'Jennifer', last_name: 'Lawrence')
    @customer8 = Customer.create!(first_name: 'Harrison', last_name: 'Ford')
    @customer9 = Customer.create!(first_name: 'Meryl', last_name: 'Streep')
    @customer10 = Customer.create!(first_name: 'Christian', last_name: 'Bale')

    #Merchant1 Items
    @item1 = @merchant1.items.create!(name: 'Milk', description: 'A large quantity of whole milk', unit_price: 500)
    @item2 = @merchant1.items.create!(name: 'Potato Chips', description: 'A large quantity of potato chips', unit_price: 700)
    @item3 = @merchant1.items.create!(name: 'Hot Dog', description: 'Best hot dog deal around', unit_price: 150)
    @item4 = @merchant1.items.create!(name: 'Steaks', description: 'A four pack of ribeyes', unit_price: 3500)

    #Added to test merchant top_five_items method
    @item13 = @merchant1.items.create!(name: 'Spinach', description: 'A 2lb bag of spinach', unit_price: 400)
    @item14 = @merchant1.items.create!(name: 'Red Bull', description: 'A pack 0f 24 can 8oz Red Bulls', unit_price: 3200)
    @item15 = @merchant1.items.create!(name: 'Hot Cheetos', description: 'A 2lb bag of Hot Cheetos', unit_price: 500)
    @item16 = @merchant1.items.create!(name: 'Toilet Paper', description: 'A pack of 24 rolls of toilet paper', unit_price: 2500)
    @item17 = @merchant1.items.create!(name: 'Hand Sanitizer', description: '32oz bottle of hand sanitizer', unit_price: 1000)

    #Merchant2 Items
    @item5 = @merchant2.items.create!(name: 'Playstation', description: 'Sony playstation, 4th generation', unit_price: 25000)
    @item6 = @merchant2.items.create!(name: 'Sheets', description: 'White bed linens', unit_price: 2000)

    #Merchant3 Items
    @item7 = @merchant3.items.create!(name: 'Apple', description: 'Red Delicious', unit_price: 100)
    @item8 = @merchant3.items.create!(name: 'Fishing Lure', description: 'Rooster Tail', unit_price: 199)

    #Merchant4 Items
    @item9 = @merchant2.items.create!(name: 'Frying Pan', description: 'High quality durable nonstick pan', unit_price: 2400)
    @item10 = @merchant2.items.create!(name: 'Paper towels', description: '20 pack of standard towels', unit_price: 1000)

    #Merchant5 Items
    @item11 = @merchant3.items.create!(name: 'Greeting Card', description: 'Hallmark happy birthday card', unit_price: 199)
    @item12 = @merchant3.items.create!(name: 'Frozen pizza', description: 'Pepperoni pizza', unit_price: 499)

    #Customer1 Invoices
    @invoice1 = @customer1.invoices.create!(status: 'completed', created_at: "Sun, 25 Mar 2012 09:54:09 UTC +00:00")
    @invoice2 = @customer1.invoices.create!(status: 'completed', created_at: "Mon, 26 Mar 2012 09:54:09 UTC +00:00")
    @invoice3 = @customer1.invoices.create!(status: 'in_progress')
    @invoice4 = @customer1.invoices.create!(status: 'in_progress')
    @invoice5 = @customer1.invoices.create!(status: 'cancelled')
    @invoice6 = @customer1.invoices.create!(status: 'cancelled')

    #Added to test merchant top_five_items method
    @invoice16 = @customer1.invoices.create!(status: 'completed')
    @invoice17 = @customer1.invoices.create!(status: 'completed')
    @invoice18 = @customer1.invoices.create!(status: 'completed')
    @invoice19 = @customer1.invoices.create!(status: 'completed')
    @invoice20 = @customer1.invoices.create!(status: 'completed')

    #Customer2 Invoices
    @invoice7 = @customer2.invoices.create!(status: 'completed')
    @invoice8 = @customer2.invoices.create!(status: 'in_progress')
    @invoice9 = @customer2.invoices.create!(status: 'cancelled')

    #Customer3 Invoices
    @invoice10 = @customer3.invoices.create!(status: 'completed')
    @invoice11 = @customer3.invoices.create!(status: 'in_progress')
    @invoice12 = @customer3.invoices.create!(status: 'cancelled')

    #Customer4 Invoices
    @invoice13 = @customer4.invoices.create!(status: 'completed')
    @invoice14 = @customer4.invoices.create!(status: 'in_progress', created_at: "Tue, 27 Mar 2012 09:54:09 UTC +00:00")
    @invoice15 = @customer4.invoices.create!(status: 'cancelled')

    #Customer5
    @invoice80 = @customer5.invoices.create!(status: 'completed')
    @invoice81 = @customer5.invoices.create!(status: 'completed')
    @invoice82 = @customer5.invoices.create!(status: 'completed')
    @invoice83 = @customer5.invoices.create!(status: 'completed')
    @invoice84 = @customer5.invoices.create!(status: 'completed')
    @invoice85 = @customer5.invoices.create!(status: 'completed')
    @invoice86 = @customer5.invoices.create!(status: 'completed')
    @invoice87 = @customer5.invoices.create!(status: 'completed')
    @invoice88 = @customer5.invoices.create!(status: 'completed')
    @invoice89 = @customer5.invoices.create!(status: 'completed')
    @transaction80 = @invoice80.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction81 = @invoice81.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction82 = @invoice82.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction83 = @invoice83.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction84 = @invoice84.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction85 = @invoice85.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction86 = @invoice86.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction87 = @invoice87.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction88 = @invoice88.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction89 = @invoice89.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

    #Customer6
    @invoice90 = @customer6.invoices.create!(status: 'completed')
    @invoice91 = @customer6.invoices.create!(status: 'completed')
    @invoice92 = @customer6.invoices.create!(status: 'completed')
    @invoice93 = @customer6.invoices.create!(status: 'completed')
    @invoice94 = @customer6.invoices.create!(status: 'completed')
    @invoice95 = @customer6.invoices.create!(status: 'completed')
    @invoice96 = @customer6.invoices.create!(status: 'completed')
    @invoice97 = @customer6.invoices.create!(status: 'completed')
    @invoice98 = @customer6.invoices.create!(status: 'completed')
    @invoice99 = @customer6.invoices.create!(status: 'completed')
    @transaction90 = @invoice90.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction91 = @invoice91.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction92 = @invoice92.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction93 = @invoice93.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction94 = @invoice94.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction95 = @invoice95.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction96 = @invoice96.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction97 = @invoice97.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction98 = @invoice98.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction99 = @invoice99.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #Customer7
    @invoice40 = @customer7.invoices.create!(status: 'completed')
    @invoice41 = @customer7.invoices.create!(status: 'completed')
    @invoice42 = @customer7.invoices.create!(status: 'completed')
    @invoice43 = @customer7.invoices.create!(status: 'completed')
    @invoice44 = @customer7.invoices.create!(status: 'completed')
    @invoice45 = @customer7.invoices.create!(status: 'completed')
    @invoice46 = @customer7.invoices.create!(status: 'completed')
    @invoice47 = @customer7.invoices.create!(status: 'completed')
    @invoice48 = @customer7.invoices.create!(status: 'completed')
    @invoice49 = @customer7.invoices.create!(status: 'completed')
    @transaction40 = @invoice40.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction41 = @invoice41.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction42 = @invoice42.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction43 = @invoice43.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction44 = @invoice44.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction45 = @invoice45.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction46 = @invoice46.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction47 = @invoice47.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction48 = @invoice48.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction49 = @invoice49.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #Customer8
    @invoice50 = @customer8.invoices.create!(status: 'completed')
    @invoice51 = @customer8.invoices.create!(status: 'completed')
    @invoice52 = @customer8.invoices.create!(status: 'completed')
    @invoice53 = @customer8.invoices.create!(status: 'completed')
    @invoice54 = @customer8.invoices.create!(status: 'completed')
    @invoice55 = @customer8.invoices.create!(status: 'completed')
    @invoice56 = @customer8.invoices.create!(status: 'completed')
    @invoice57 = @customer8.invoices.create!(status: 'completed')
    @invoice58 = @customer8.invoices.create!(status: 'completed')
    @invoice59 = @customer8.invoices.create!(status: 'completed')
    @transaction50 = @invoice50.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction51 = @invoice51.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction52 = @invoice52.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction53 = @invoice53.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction54 = @invoice54.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction55 = @invoice55.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction56 = @invoice56.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction57 = @invoice57.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction58 = @invoice58.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction59 = @invoice59.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #Customer9
    @invoice60 = @customer9.invoices.create!(status: 'completed')
    @invoice61 = @customer9.invoices.create!(status: 'completed')
    @invoice62 = @customer9.invoices.create!(status: 'completed')
    @invoice63 = @customer9.invoices.create!(status: 'completed')
    @invoice64 = @customer9.invoices.create!(status: 'completed')
    @invoice65 = @customer9.invoices.create!(status: 'completed')
    @invoice66 = @customer9.invoices.create!(status: 'completed')
    @invoice67 = @customer9.invoices.create!(status: 'completed')
    @invoice68 = @customer9.invoices.create!(status: 'completed')
    @invoice69 = @customer9.invoices.create!(status: 'completed')
    @transaction60 = @invoice60.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction61 = @invoice61.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction62 = @invoice62.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction63 = @invoice63.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction64 = @invoice64.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction65 = @invoice65.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction66 = @invoice66.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction67 = @invoice67.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction68 = @invoice68.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction69 = @invoice69.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #Customer10
    @invoice70 = @customer10.invoices.create!(status: 'completed')
    @invoice71 = @customer10.invoices.create!(status: 'completed')
    @invoice72 = @customer10.invoices.create!(status: 'completed')
    @invoice73 = @customer10.invoices.create!(status: 'completed')
    @invoice74 = @customer10.invoices.create!(status: 'completed')
    @invoice75 = @customer10.invoices.create!(status: 'completed')
    @invoice76 = @customer10.invoices.create!(status: 'completed')
    @invoice77 = @customer10.invoices.create!(status: 'completed')
    @invoice78 = @customer10.invoices.create!(status: 'completed')
    @invoice79 = @customer10.invoices.create!(status: 'completed')
    @transaction70 = @invoice70.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction71 = @invoice71.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction72 = @invoice72.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction73 = @invoice73.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction74 = @invoice74.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction75 = @invoice75.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction76 = @invoice76.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction77 = @invoice77.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction78 = @invoice78.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction79 = @invoice79.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #InvoiceItems for all items once
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'shipped')
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')
    @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item3.id, quantity: 100, unit_price: @item3.unit_price, status: 'pending')
    @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item4.id, quantity: 100, unit_price: @item4.unit_price, status: 'shipped')
    @invoice_item5 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item5.id, quantity: 100, unit_price: @item5.unit_price, status: 'packaged')
    @invoice_item6 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item6.id, quantity: 100, unit_price: @item6.unit_price, status: 'pending')
    @invoice_item7 = InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item7.id, quantity: 100, unit_price: @item7.unit_price, status: 'shipped')
    @invoice_item8 = InvoiceItem.create!(invoice_id: @invoice8.id, item_id: @item8.id, quantity: 100, unit_price: @item8.unit_price, status: 'packaged')
    @invoice_item9 = InvoiceItem.create!(invoice_id: @invoice9.id, item_id: @item9.id, quantity: 100, unit_price: @item9.unit_price, status: 'pending')
    @invoice_item10 = InvoiceItem.create!(invoice_id: @invoice10.id, item_id: @item10.id, quantity: 100, unit_price: @item10.unit_price, status: 'shipped')
    @invoice_item11 = InvoiceItem.create!(invoice_id: @invoice11.id, item_id: @item11.id, quantity: 100, unit_price: @item11.unit_price, status: 'packaged')
    @invoice_item12 = InvoiceItem.create!(invoice_id: @invoice12.id, item_id: @item12.id, quantity: 100, unit_price: @item12.unit_price, status: 'pending')

    #Added to test merchant top_five_items method
    @invoice_item17 = InvoiceItem.create!(invoice_id: @invoice16.id, item_id: @item13.id, quantity: 100, unit_price: @item13.unit_price, status: 'packaged')
    @invoice_item18 = InvoiceItem.create!(invoice_id: @invoice17.id, item_id: @item14.id, quantity: 100, unit_price: @item14.unit_price, status: 'packaged')
    @invoice_item19 = InvoiceItem.create!(invoice_id: @invoice18.id, item_id: @item15.id, quantity: 100, unit_price: @item15.unit_price, status: 'packaged')
    @invoice_item20 = InvoiceItem.create!(invoice_id: @invoice19.id, item_id: @item16.id, quantity: 100, unit_price: @item16.unit_price, status: 'shipped')
    @invoice_item21 = InvoiceItem.create!(invoice_id: @invoice20.id, item_id: @item17.id, quantity: 100, unit_price: @item17.unit_price, status: 'shipped')

    # InvoiceItems with repeat items
    @invoice_item13 = InvoiceItem.create!(invoice_id: @invoice13.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'shipped')
    @invoice_item14 = InvoiceItem.create!(invoice_id: @invoice14.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')

    # InvoiceItems for invoice 1 to have more items
    @invoice_item15 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 25, unit_price: @item2.unit_price, status: 'packaged')
    @invoice_item16 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 75, unit_price: @item3.unit_price, status: 'pending')


    # Transactions
    @transaction1 = @invoice1.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction4 = @invoice4.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction7 = @invoice7.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction8 = @invoice8.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction9 = @invoice9.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction10 = @invoice10.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction11 = @invoice11.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction12 = @invoice12.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
    @transaction13 = @invoice13.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction14 = @invoice14.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

    #Added to test merchant top_five_items method
    @transaction15 = @invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction16 = @invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction17 = @invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction18 = @invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
    @transaction19 = @invoice20.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
  end

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
