require 'rails_helper'

RSpec.describe 'Admin Invoices Item Index' do
    describe 'As a Invoice' do
        describe 'When I visit the admin Invoices index page' do

            it "is able to list all of the invoices ids in the system" do

              merchant1 = Merchant.create!(name: "Poke Retirement homes")
        			merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        			merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        			item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
              item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
              item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        			customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        			invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
              invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        			transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        		  invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
              invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
              invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

              visit '/admin/invoices'

              expect(page).to have_content(invoice1.id)
              expect(page).to have_content(invoice2.id)

            end

        end
    end

end
