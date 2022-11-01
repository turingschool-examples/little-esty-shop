require 'rails_helper'

RSpec.describe 'On the Merchant Dashboard Index Page' do
  describe 'When I visit /merchants/:merchant_id/dashboard' do
# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Dave")

      # @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
      # @merchant_1_item_2 = @merchant_1.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 1)
      # @merchant_1_item_3 = @merchant_1.items.create!(name: "Pen", description: "Writing implement", unit_price: 1)
      # @merchant_1_item_4 = @merchant_1.items.create!(name: "Fountain Pen", description: "Writing implement", unit_price: 1)
      # @merchant_1_item_5 = @merchant_1.items.create!(name: "Stationery", description: "Writing implement", unit_price: 1)

      @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
      @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")
      @customer_3 = Customer.create!(first_name: "David", last_name: "Hill")
      @customer_4 = Customer.create!(first_name: "Sarah", last_name: "Miller")
      @customer_5 = Customer.create!(first_name: "Patrick", last_name: "Baker")
      @customer_6 = Customer.create!(first_name: "Rebecca", last_name: "Jones")

      #invoice status: 0 cancelled, 1 completed, 2 in progress
      @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1)
      @customer_2_invoice_1 = @customer_2.invoices.create!(status: 1)
      @customer_3_invoice_1 = @customer_3.invoices.create!(status: 1)
      @customer_4_invoice_1 = @customer_4.invoices.create!(status: 1)
      @customer_5_invoice_1 = @customer_5.invoices.create!(status: 1)
      @customer_6_invoice_1 = @customer_6.invoices.create!(status: 1)
      @customer_6_invoice_2 = @customer_6.invoices.create!(status: 0)

      #transaction result: success or failed
      @customer_1_transaction_1 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_1_transaction_2 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_1_transaction_3 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_2_transaction_1 = @customer_2_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_2_transaction_2 = @customer_2_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_3_transaction_1 = @customer_3_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_3_transaction_2 = @customer_3_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_4_transaction_1 = @customer_4_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_4_transaction_2 = @customer_4_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_5_transaction_1 = @customer_5_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_5_transaction_2 = @customer_5_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_6_transaction_1 = @customer_6_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_6_transaction_2 = @customer_6_invoice_2.transactions.create!(credit_card_number: 1234123412341234, result: 'failed')

      visit "/merchants/#{@merchant_1.id}/dashboard"
    end
    describe 'Then I see' do
      it 'the name of the merchant' do
        within "#attributes-merchant-#{@merchant_1.id}" do
          expect(page).to have_content(@merchant_1.name)
        end
      end

      it 'a link to merchant items index /merchants/:merchant_id/items' do
        within "#links-merchant-#{@merchant_1.id}" do
          expect(page).to have_link("#{@merchant_1.name} Items")
          click_link("#{@merchant_1.name} Items")
          expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
        end
      end

      it 'a link to merchant invoices index /merchants/:merchant_id/invoices' do
        within "#links-merchant-#{@merchant_1.id}" do
          expect(page).to have_link("#{@merchant_1.name} Items")
          click_link("#{@merchant_1.name} Invoices")
          expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
        end
      end

      it 'a list of the merchants top five customers with an item counter next to each one' do
        within "#top-customers-merchant-#{@merchant_1.id}" do
          expect(page).to have_content("#{@customer_1.last_name}, #{@customer_1.first_name}: 3 Transactions")
          expect(page).to have_content("#{@customer_2.last_name}, #{@customer_2.first_name}: 2 Transactions")
          expect(page).to have_content("#{@customer_3.last_name}, #{@customer_3.first_name}: 2 Transactions")
          expect(page).to have_content("#{@customer_4.last_name}, #{@customer_4.first_name}: 2 Transactions")
          expect(page).to have_content("#{@customer_5.last_name}, #{@customer_5.first_name}: 2 Transactions")
          expect(page).to_not have_content("#{@customer_6.last_name}, #{@customer_6.first_name}")
        end
      end
    end
  end
end
@customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
      @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")
      @customer_3 = Customer.create!(first_name: "David", last_name: "Hill")
      @customer_4 = Customer.create!(first_name: "Sarah", last_name: "Miller")
      @customer_5 = Customer.create!(first_name: "Patrick", last_name: "Baker")