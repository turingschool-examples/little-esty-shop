

def test_data
  @merchant_1 = FactoryBot.create(:merchant)
  @merchant_2 = FactoryBot.create(:merchant)
  @merchant_3 = FactoryBot.create(:merchant)
  @merchant_4 = FactoryBot.create(:merchant)
  @merchant_5 = FactoryBot.create(:merchant)
  @merchant_6 = FactoryBot.create(:merchant)
  @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 100)
  @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Description 2', unit_price: 200)
  @item_3 = @merchant_1.items.create!(name: 'Item 3', description: 'Description 3', unit_price: 300)
  @item_4 = @merchant_1.items.create!(name: 'Item 4', description: 'Description 4', unit_price: 400)
  @item_5 = @merchant_1.items.create!(name: 'Item 5', description: 'Description 5', unit_price: 500)
  @item_6 = @merchant_1.items.create!(name: 'Item 6', description: 'Description 6', unit_price: 600)
  @item_7 = @merchant_1.items.create!(name: 'Item 7', description: 'Description 7', unit_price: 700)
  @item_8 = @merchant_2.items.create!(name: 'Item 8', description: 'Description 8', unit_price: 800)
  @item_9 = @merchant_2.items.create!(name: 'Item 9', description: 'Description 9', unit_price: 900)
  @item_10 = @merchant_2.items.create!(name: 'Item 10', description: 'Description 10', unit_price: 1000)
  @item_11 = @merchant_2.items.create!(name: 'Item 11', description: 'Description 11', unit_price: 1100)
  @item_12 = @merchant_2.items.create!(name: 'Item 12', description: 'Description 12', unit_price: 1200)
  @item_13 = @merchant_2.items.create!(name: 'Item 13', description: 'Description 13', unit_price: 1300)
  @item_14 = @merchant_2.items.create!(name: 'Item 14', description: 'Description 14', unit_price: 1400)
  @item_15 = @merchant_3.items.create!(name: 'Item 15', description: 'Description 15', unit_price: 1500)
  @item_16 = @merchant_3.items.create!(name: 'Item 16', description: 'Description 16', unit_price: 1600)
  @item_17 = @merchant_3.items.create!(name: 'Item 17', description: 'Description 17', unit_price: 1700)
  @item_18 = @merchant_3.items.create!(name: 'Item 18', description: 'Description 18', unit_price: 1800)
  @item_19 = @merchant_3.items.create!(name: 'Item 19', description: 'Description 19', unit_price: 1900)
  @item_20 = @merchant_3.items.create!(name: 'Item 20', description: 'Description 20', unit_price: 2000)
  @item_21 = @merchant_3.items.create!(name: 'Item 21', description: 'Description 21', unit_price: 2100)
  @item_22 = @merchant_4.items.create!(name: 'Item 22', description: 'Description 22', unit_price: 2200)
  @item_23 = @merchant_4.items.create!(name: 'Item 23', description: 'Description 23', unit_price: 2300)
  @item_24 = @merchant_4.items.create!(name: 'Item 24', description: 'Description 24', unit_price: 2400)
  @item_25 = @merchant_4.items.create!(name: 'Item 25', description: 'Description 25', unit_price: 2500)
  @item_26 = @merchant_4.items.create!(name: 'Item 26', description: 'Description 26', unit_price: 2600)
  @item_27 = @merchant_4.items.create!(name: 'Item 27', description: 'Description 27', unit_price: 2700)
  @item_28 = @merchant_4.items.create!(name: 'Item 28', description: 'Description 28', unit_price: 2800)
  @item_29 = @merchant_5.items.create!(name: 'Item 29', description: 'Description 29', unit_price: 2900)
  @item_30 = @merchant_5.items.create!(name: 'Item 30', description: 'Description 30', unit_price: 3000)
  @item_31 = @merchant_5.items.create!(name: 'Item 31', description: 'Description 31', unit_price: 3100)
  @item_32 = @merchant_5.items.create!(name: 'Item 32', description: 'Description 32', unit_price: 3200)
  @item_33 = @merchant_5.items.create!(name: 'Item 33', description: 'Description 33', unit_price: 3300)
  @item_34 = @merchant_5.items.create!(name: 'Item 34', description: 'Description 34', unit_price: 3400)
  @item_35 = @merchant_5.items.create!(name: 'Item 35', description: 'Description 35', unit_price: 3500)
  @item_36 = @merchant_6.items.create!(name: 'Item 36', description: 'Description 36', unit_price: 3600)
  @item_37 = @merchant_6.items.create!(name: 'Item 37', description: 'Description 37', unit_price: 3700)
  @item_38 = @merchant_6.items.create!(name: 'Item 38', description: 'Description 38', unit_price: 3800)
  @item_39 = @merchant_6.items.create!(name: 'Item 39', description: 'Description 39', unit_price: 3900)
  @item_40 = @merchant_6.items.create!(name: 'Item 40', description: 'Description 40', unit_price: 4000)
  @item_41 = @merchant_6.items.create!(name: 'Item 41', description: 'Description 41', unit_price: 4100)
  @item_42 = @merchant_6.items.create!(name: 'Item 42', description: 'Description 42', unit_price: 4200)
  @customer_1 = Customer.create!(first_name: 'Customer', last_name: 'One')
  @customer_2 = Customer.create!(first_name: 'Customer', last_name: 'Two')
  @customer_3 = Customer.create!(first_name: 'Customer', last_name: 'Three')
  @customer_4 = Customer.create!(first_name: 'Customer', last_name: 'Four')
  @customer_5 = Customer.create!(first_name: 'Customer', last_name: 'Five')
  @customer_6 = Customer.create!(first_name: 'Customer', last_name: 'Six')
  @invoice_1 = @customer_1.invoices.create!(status: 1)
  @invoice_2 = @customer_1.invoices.create!(status: 1)
  @invoice_3 = @customer_1.invoices.create!(status: 1)
  @invoice_4 = @customer_2.invoices.create!(status: 1)
  @invoice_5 = @customer_2.invoices.create!(status: 1)
  @invoice_6 = @customer_3.invoices.create!(status: 1)
  @invoice_7 = @customer_3.invoices.create!(status: 1)
  @invoice_8 = @customer_4.invoices.create!(status: 1)
  @invoice_9 = @customer_4.invoices.create!(status: 1)
  @invoice_10 = @customer_5.invoices.create!(status: 1)
  @invoice_11 = @customer_5.invoices.create!(status: 1)
  @invoice_12 = @customer_5.invoices.create!(status: 1)
  @invoice_13 = @customer_5.invoices.create!(status: 1)
  @invoice_14 = @customer_6.invoices.create!(status: 1)
  @invoice_15 = @customer_6.invoices.create!(status: 1)
  @invoice_16 = @customer_6.invoices.create!(status: 1)
  @invoice_17 = @customer_6.invoices.create!(status: 1)
  @invoice_18 = @customer_6.invoices.create!(status: 1)
  @invoice_19 = @customer_6.invoices.create!(status: 1)
  @invoice_20 = @customer_6.invoices.create!(status: 1)
  @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 100, status: 1)
  @invoice_item_2 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 100, status: 1)
  @invoice_item_3 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 3, unit_price: 100, status: 1)
  @invoice_item_4 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 4, unit_price: 100, status: 1)
  @invoice_item_5 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 5, unit_price: 100, status: 1)
  @invoice_item_6 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 6, unit_price: 100, status: 1)
  @invoice_item_7 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 7, unit_price: 100, status: 1)
  @invoice_item_8 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 8, unit_price: 100, status: 1)
  @invoice_item_9 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 9, unit_price: 100, status: 1)
  @invoice_item_10 = @invoice_10.invoice_items.create!(item: @item_1, quantity: 10, unit_price: 100, status: 1)
  @invoice_item_11 = @invoice_11.invoice_items.create!(item: @item_1, quantity: 11, unit_price: 100, status: 1)
  @invoice_item_12 = @invoice_12.invoice_items.create!(item: @item_1, quantity: 12, unit_price: 100, status: 1)
  @invoice_item_13 = @invoice_13.invoice_items.create!(item: @item_1, quantity: 13, unit_price: 100, status: 1)
  @invoice_item_14 = @invoice_14.invoice_items.create!(item: @item_1, quantity: 14, unit_price: 100, status: 1)
  @invoice_item_15 = @invoice_15.invoice_items.create!(item: @item_1, quantity: 15, unit_price: 100, status: 1)
  @invoice_item_16 = @invoice_16.invoice_items.create!(item: @item_1, quantity: 16, unit_price: 100, status: 1)
  @invoice_item_17 = @invoice_17.invoice_items.create!(item: @item_1, quantity: 17, unit_price: 100, status: 1)
  @invoice_item_18 = @invoice_18.invoice_items.create!(item: @item_1, quantity: 18, unit_price: 100, status: 1)
  @invoice_item_19 = @invoice_19.invoice_items.create!(item: @item_1, quantity: 19, unit_price: 100, status: 1)
  @invoice_item_20 = @invoice_20.invoice_items.create!(item: @item_1, quantity: 20, unit_price: 100, status: 1)
  @invoice_item_21 = @invoice_1.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_22 = @invoice_2.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_23 = @invoice_3.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_24 = @invoice_4.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_25 = @invoice_5.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_26 = @invoice_6.invoice_items.create!(item: @item_7, quantity: 1, unit_price: 700, status: 1)
  @invoice_item_27 = @invoice_7.invoice_items.create!(item: @item_14, quantity: 1, unit_price: 1400, status: 1)
  @invoice_item_28 = @invoice_8.invoice_items.create!(item: @item_14, quantity: 1, unit_price: 1400, status: 1)
  @invoice_item_29 = @invoice_9.invoice_items.create!(item: @item_14, quantity: 1, unit_price: 1400, status: 1)
  @invoice_item_30 = @invoice_10.invoice_items.create!(item: @item_14, quantity: 1, unit_price: 1400, status: 1)
  @invoice_item_31 = @invoice_11.invoice_items.create!(item: @item_14, quantity: 1, unit_price: 1400, status: 1)
  @invoice_item_32 = @invoice_12.invoice_items.create!(item: @item_15, quantity: 1, unit_price: 1500, status: 1)
  @invoice_item_33 = @invoice_13.invoice_items.create!(item: @item_15, quantity: 1, unit_price: 1500, status: 1)
  @invoice_item_34 = @invoice_14.invoice_items.create!(item: @item_15, quantity: 1, unit_price: 1500, status: 1)
  @invoice_item_35 = @invoice_15.invoice_items.create!(item: @item_16, quantity: 1, unit_price: 1600, status: 1)
  @invoice_item_36 = @invoice_16.invoice_items.create!(item: @item_16, quantity: 1, unit_price: 1600, status: 1)
  @invoice_item_37 = @invoice_17.invoice_items.create!(item: @item_16, quantity: 1, unit_price: 1600, status: 1)
  @invoice_item_38 = @invoice_18.invoice_items.create!(item: @item_17, quantity: 1, unit_price: 1700, status: 1)
  @invoice_item_39 = @invoice_19.invoice_items.create!(item: @item_17, quantity: 1, unit_price: 1700, status: 1)
  @invoice_item_40 = @invoice_20.invoice_items.create!(item: @item_17, quantity: 1, unit_price: 1700, status: 1)
  @invoice_item_41 = @invoice_1.invoice_items.create!(item: @item_18, quantity: 1, unit_price: 1800, status: 1)
  @invoice_item_42 = @invoice_2.invoice_items.create!(item: @item_18, quantity: 1, unit_price: 1800, status: 1)
  @invoice_item_43 = @invoice_3.invoice_items.create!(item: @item_18, quantity: 1, unit_price: 1800, status: 1)
  @invoice_item_44 = @invoice_4.invoice_items.create!(item: @item_19, quantity: 1, unit_price: 1900, status: 1)
  @invoice_item_45 = @invoice_5.invoice_items.create!(item: @item_19, quantity: 1, unit_price: 1900, status: 1)
  @invoice_item_46 = @invoice_6.invoice_items.create!(item: @item_19, quantity: 1, unit_price: 1900, status: 1)
  @invoice_item_47 = @invoice_7.invoice_items.create!(item: @item_20, quantity: 1, unit_price: 2000, status: 1)
  @invoice_item_48 = @invoice_8.invoice_items.create!(item: @item_20, quantity: 1, unit_price: 2000, status: 1)
  @invoice_item_49 = @invoice_9.invoice_items.create!(item: @item_20, quantity: 1, unit_price: 2000, status: 1)
  @invoice_item_50 = @invoice_10.invoice_items.create!(item: @item_21, quantity: 1, unit_price: 2100, status: 1)
  @invoice_item_51 = @invoice_11.invoice_items.create!(item: @item_21, quantity: 1, unit_price: 2100, status: 1)
  @invoice_item_52 = @invoice_12.invoice_items.create!(item: @item_21, quantity: 1, unit_price: 2100, status: 1)
  @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_19 = @invoice_19.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_20 = @invoice_20.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
end

# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
