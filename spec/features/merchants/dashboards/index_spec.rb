require 'rails_helper'
require 'date'

RSpec.describe 'On the Merchant Dashboard Index Page' do
  describe 'When I visit /merchants/:merchant_id/dashboard' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Dave")
      @merchant_2 = Merchant.create!(name: "Kevin")

      @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
      @merchant_1_item_not_ordered = @merchant_1.items.create!(name: "Unordered Item", description: "...", unit_price: 2)
      @merchant_1_item_3 = @merchant_1.items.create!(name: "Newest Item", description: "...", unit_price: 1)
      @merchant_2_item_1 = @merchant_2.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 2)

      @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
      @customer_2 = Customer.create!(first_name: "Milly", last_name: "Smith")
      @customer_3 = Customer.create!(first_name: "David", last_name: "Hill")
      @customer_4 = Customer.create!(first_name: "Sarah", last_name: "Miller")
      @customer_5 = Customer.create!(first_name: "Patrick", last_name: "Baker")
      @customer_6 = Customer.create!(first_name: "Rebecca", last_name: "Simpson")

      date = DateTime.new(2022,11,2,3,4,5)
      #invoice status: 0 cancelled, 1 completed, 2 in progress

      datetime = DateTime.iso8601('2022-11-01', Date::ENGLAND)
      @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1, created_at: datetime)
      @customer_1_invoice_2 = @customer_1.invoices.create!(status: 1)


      @customer_2_invoice_1 = @customer_2.invoices.create!(status: 1, created_at: date)
      @customer_3_invoice_1 = @customer_3.invoices.create!(status: 1, created_at: date)
      @customer_4_invoice_1 = @customer_4.invoices.create!(status: 1, created_at: date)
      @customer_5_invoice_1 = @customer_5.invoices.create!(status: 1, created_at: date)

      @customer_6_invoice_1 = @customer_6.invoices.create!(status: 1, created_at: date)
      @customer_6_invoice_2 = @customer_6.invoices.create!(status: 0, created_at: date)

      @invoice_item_1 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
      InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_2_item_1, quantity: 1, unit_price: 4, status: 0)

      InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
      InvoiceItem.create!(invoice: @customer_3_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
      InvoiceItem.create!(invoice: @customer_4_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
      InvoiceItem.create!(invoice: @customer_5_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)

      @invoice_item_2 = InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
      @invoice_item_3 = InvoiceItem.create!(invoice: @customer_6_invoice_2, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 1)

      @customer_1_transaction_1 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_1_transaction_2 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_1_transaction_3 = @customer_1_invoice_1.transactions.create!(credit_card_number: 1234123412341234, result: 'success')
      @customer_1_transaction_4 = @customer_1_invoice_2.transactions.create!(credit_card_number: 1234123412341234, result: 'success')

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
        expect(page).to have_content("#{@merchant_1.name}'s Shop")
      end

      it 'a link to merchant items index /merchants/:merchant_id/items' do
        expect(page).to have_link("My Items")
        click_link("My Items")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      end

      it 'a link to merchant invoices index /merchants/:merchant_id/invoices' do
        expect(page).to have_link("My Invoices")
        click_link("My Invoices")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
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

      describe 'a section for items ready to ship' do
        it 'listing all the names of items that have been "ordered" and NOT "shipped"' do
          within "#items-to-ship-merchant-#{@merchant_1.id}" do
            expect(page).to have_content(@merchant_1_item_1.name)
            expect(page).to_not have_content(@merchant_1_item_not_ordered.name)
            expect(page).to_not have_content(@merchant_2_item_1.name)
          end
        end

        it 'next to each listed item is the id of the invoice that ordered it' do
          within "#items-to-ship-merchant-#{@merchant_1.id}" do
            expect(page).to have_content("#{@merchant_1_item_1.name}: Invoice # #{@customer_6_invoice_1.id}")
            expect(page).to_not have_content("#{@merchant_1_item_1.name}: Invoice # #{@customer_1_invoice_1.id}")
            expect(page).to_not have_content("#{@merchant_1_item_1.name}: Invoice # #{@customer_6_invoice_2.id}")
          end
        end

        describe 'next to each listed item and invoice id is the date that the invoice was created it' do
          it 'formatted as Weekday, Month DD, YYYY' do
            within "#items-to-ship-merchant-#{@merchant_1.id}" do
              expect(@invoice_item_1.invoice_date).to eq("Tuesday, 01 November 2022")
            end
          end
        end

        it 'listed from oldest to newest' do
          within "#items-to-ship-merchant-#{@merchant_1.id}" do
            customer_7 = Customer.create!(first_name: "Newest", last_name: "Customer")
            customer_7_invoice_1 = customer_7.invoices.create!(status: 1)
            InvoiceItem.create!(invoice: customer_7_invoice_1, item: @merchant_1_item_3, quantity: 1, unit_price: 4, status: 0)
            visit "/merchants/#{@merchant_1.id}/dashboard"

            expect(@merchant_1_item_1.name).to appear_before(@merchant_1_item_3.name, only_text: true)
          end
        end

        xit 'each invoice_id is a link to invoice show page' do
          within "#items-to-ship-merchant-#{@merchant_1.id}" do
            click_link("Invoice # #{@customer_6_invoice_1.id}")
            expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@customer_6_invoice_1.id}")
          end
        end
      end
    end
  end
end