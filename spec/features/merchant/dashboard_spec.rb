require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe 'As a merchant' do
    describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)' do
      before(:each) do
        @max = Merchant.create!(name: 'Merch Max')
      end

      it "Then I see the name of my merchant" do
        visit "/merchants/#{@max.id}/dashboard"

        expect(page).to have_content(@max.name)
      end

      it "Then I see links to my merchant items and invoices indexes (/merchants/merchant_id/items)" do
        visit "/merchants/#{@max.id}/dashboard"

        expect(page).to have_link('Items', href: "/merchants/#{@max.id}/items")
        expect(page).to have_link('Invoices', href: "/merchants/#{@max.id}/invoices")
      end

      it "merchant dashboard displays top 5 customers with most succesful transactions" do
        sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
        joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
        john     = Customer.create!(first_name: 'John', last_name: 'Hansen')
        travolta = Customer.create!(first_name: 'Travolta', last_name: 'Hansen')
        sal      = Customer.create!(first_name: 'Sal', last_name: 'Hansen')
        tim      = Customer.create!(first_name: 'Tim', last_name: 'Hansen')
        amazon   = Merchant.create!(name: 'Amazon')
        alibaba  = Merchant.create!(name: 'Alibaba')
        invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: amazon.id)
        invoice2 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: amazon.id)
        invoice3 = Invoice.create!(status: 1, customer_id: joel.id, merchant_id: amazon.id)
        invoice4 = Invoice.create!(status: 1, customer_id: joel.id, merchant_id: amazon.id)
        invoice5 = Invoice.create!(status: 1, customer_id: john.id, merchant_id: amazon.id)
        invoice6 = Invoice.create!(status: 1, customer_id: john.id, merchant_id: amazon.id)
        invoice7 = Invoice.create!(status: 1, customer_id: travolta.id, merchant_id: amazon.id)
        invoice8 = Invoice.create!(status: 1, customer_id: travolta.id, merchant_id: amazon.id)
        invoice9 = Invoice.create!(status: 1, customer_id: sal.id, merchant_id: amazon.id)
        invoice10 = Invoice.create!(status: 1, customer_id: sal.id, merchant_id: amazon.id)
        invoice11 = Invoice.create!(status: 1, customer_id: tim.id, merchant_id: amazon.id)
        invoice13 = Invoice.create!(status: 0, customer_id: sally.id, merchant_id: amazon.id)
        invoice14 = Invoice.create!(status: 0, customer_id: sally.id, merchant_id: alibaba.id)
        tx1      = Transaction.create!(result: "success", credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: invoice2.id,)
        tx2      = Transaction.create!(result: "success", credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: invoice1.id,)
        tx3      = Transaction.create!(result: "success", credit_card_number: 010001005551, credit_card_expiration_date: 20220101, invoice_id: invoice3.id,)
        tx4      = Transaction.create!(result: "success", credit_card_number: 010001005552, credit_card_expiration_date: 20220101, invoice_id: invoice4.id,)
        tx5      = Transaction.create!(result: "success", credit_card_number: 010001005553, credit_card_expiration_date: 20220101, invoice_id: invoice5.id,)
        tx6      = Transaction.create!(result: "success", credit_card_number: 010001005554, credit_card_expiration_date: 20220101, invoice_id: invoice6.id,)
        tx7      = Transaction.create!(result: "success", credit_card_number: 010001005550, credit_card_expiration_date: 20220101, invoice_id: invoice7.id,)
        tx8      = Transaction.create!(result: "success", credit_card_number: 010001005556, credit_card_expiration_date: 20220101, invoice_id: invoice8.id,)
        tx9      = Transaction.create!(result: "success", credit_card_number: 010001005557, credit_card_expiration_date: 20220101, invoice_id: invoice9.id,)
        tx10     = Transaction.create!(result: "success", credit_card_number: 010001005523, credit_card_expiration_date: 20220101, invoice_id: invoice10.id,)
        tx11     = Transaction.create!(result: "success", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: invoice11.id,)
        tx12     = Transaction.create!(result: "failure", credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: invoice14.id,)

        visit "/merchants/#{amazon.id}/dashboard"

        within('.merchant-top-5-customers-list') do
          expect(page).to have_content("#{sally.first_name}: 2")
          expect(page).to have_content("#{joel.first_name}: 2")
          expect(page).to have_content("#{john.first_name}: 2")
          expect(page).to have_content("#{travolta.first_name}: 2")
          expect(page).to have_content("#{sal.first_name}: 2")
          expect(page).to_not have_content("#{tim.first_name}: 2")
        end
      end

      describe "Then I see a section for 'Items Ready to Ship'" do
        it 'In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped' do
          item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
          item_2 = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
          item_3 = @max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)

          sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
          invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: @max.id)

          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: 0)
          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1)
          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: 2)

          visit "/merchants/#{@max.id}/dashboard"

          within('.items-rdy-to-ship') do
            expect(page).to have_content('Items Ready to Ship')
            expect(page).to have_content(item_1.name)
            expect(page).to have_content(item_2.name)
            expect(page).to have_link("#{item_1.id}")
            expect(page).to have_link("#{item_2.id}")
          end

          click_on "#{item_1.id}"

          expect(current_path).to eq("/merchants/#{@max.id}/items/#{item_1.id}")

          visit "/merchants/#{@max.id}/dashboard"

          click_on "#{item_2.id}"

          expect(current_path).to eq("/merchants/#{@max.id}/items/#{item_2.id}")
        end

        it "I see the associated invoices created at date ordered from oldest to newest" do
          item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
          item_2 = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
          item_3 = @max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)
          item_4 = @max.items.create!(name: 'Item 4', description: 'Item 4 Description...', unit_price: 20)

          sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
          lisa    = Customer.create!(first_name: 'Lisa', last_name: 'John')
          invoice1 = Invoice.create!(status: 1, customer_id: sally.id, merchant_id: @max.id, created_at: '2010-02-21 09:54:09 UTC')
          invoice2 = Invoice.create!(status: 1, customer_id: lisa.id, merchant_id: @max.id, created_at: '2012-03-25 09:54:09 UTC')

          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: 0)
          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1)
          InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: 2)
          InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: 1)
# require "pry"; binding.pry
          visit "/merchants/#{@max.id}/dashboard"
          
          within('.items-rdy-to-ship') do
            expect(page).to have_content(invoice1.created_at.strftime("%A, %B %d, %Y"))
            expect(page).to have_content(invoice2.created_at.strftime("%A, %B %d, %Y"))
            expect(invoice1.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice2.created_at.strftime("%A, %B %d, %Y"))
          end
        end
      end
    end
  end
end
