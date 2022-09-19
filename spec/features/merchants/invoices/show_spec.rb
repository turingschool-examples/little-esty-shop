require "rails_helper"


RSpec.describe "the merchant invoices show"  do
    describe 'I see all information related to that invoice' do
        it 'can display the invoice id' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Invoice: #{invoice_1.id}")
        end

        it 'can display the invoice status' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Status: #{invoice_1.status}")
        end

        it 'can display the date format for its creation date' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
            
            visit merchant_invoice_path(merchant1, invoice_1)
            
            expect(page).to have_content("Created: #{invoice_1.created_at.strftime("%A,%B %d, %Y")}")
        end

        it 'can display the customers first and last name' do
            merchant1 = Merchant.create!(name: "Bob")
            customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
            invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")

            visit merchant_invoice_path(merchant1, invoice_1)
            expect(page).to have_content("Customer: #{customer1.first_name} #{customer1.last_name}")
        end

        describe 'I can see the item information within that invoice' do
            it 'can display the item name' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)

                visit merchant_invoice_path(merchant1, invoice_1)

                expect(page).to have_content("#{item1.name}")
                expect(page).to have_content("#{item2.name}")
                expect(page).to have_content("#{item3.name}")
                expect(page).to_not have_content("#{item4.name}")
            end
       
            it 'can display the quantity of that item' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)
                

                visit merchant_invoice_path(merchant1, invoice_1)

                expect(page).to have_content("#{invoice_item1.quantity}")
                expect(page).to have_content("#{invoice_item2.quantity}")
                expect(page).to have_content("#{invoice_item3.quantity}")
            end

            it 'can display the price that item sold for' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)

                visit merchant_invoice_path(merchant1, invoice_1)
                
                expect(page).to have_content("#{item1.unit_price}")
                expect(page).to have_content("#{item2.unit_price}")
                expect(page).to have_content("#{item3.unit_price}")
            end

            it 'can display the invoice item status' do
                merchant1 = Merchant.create!(name: "Bob")
                merchant2 = Merchant.create!(name: "Mark")
                customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
                invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
                item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
                item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
                item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
                item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
                invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
                invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 1, status: 0)
                invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 1, status: 0)    

                visit merchant_invoice_path(merchant1, invoice_1)
                
                expect(page).to have_content("#{invoice_item1.status}")
                expect(page).to have_content("#{invoice_item2.status}")
                expect(page).to have_content("#{invoice_item3.status}")
            end
        end
    end
end