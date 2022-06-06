require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
    describe "Merchant Invoice Show Page" do
        before :each do
            @merch1 = Merchant.create!(name: 'Floopy Fopperations')
            @merch2 = Merchant.create!(name: 'Beauty Products 101')
            @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
            @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
            @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
            @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
            @item4 = @merch2.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
            @invoice1 = @customer1.invoices.create!(status: 0)
            @invoice2 = @customer1.invoices.create!(status: 0)
            InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0)
            InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1300, status: 1)
            InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 20, unit_price: 2000, status: 1)
            InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 2)
            InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 2)
        end

        it "displays all items on invoice including name, quantity, price and status" do
            visit "/merchants/#{@merch1.id}/invoices/#{@invoice1.id}"
            within "#invoice-item-#{@item1.id}" do
                expect(page).to have_content("Name: Floopy Original")
                expect(page).to have_content("Quantity: 5")
                expect(page).to have_content("Unit Price: 1000")
                expect(page).to have_content("Status: pending")
                expect(page).to_not have_content("Name: Floopy Geo")
                expect(page).to_not have_content("Status: cancelled")
            end
            within "#invoice-item-#{@item3.id}" do
                expect(page).to have_content("Name: Floopy Retro")
                expect(page).to have_content("Quantity: 20")
                expect(page).to have_content("Unit Price: 2000")
                expect(page).to have_content("Status: packaged")
                expect(page).to_not have_content("Name: Floopy Geo")
                expect(page).to_not have_content("Quantity: 5")
                expect(page).to_not have_content("Unit Price: 1000")
                expect(page).to_not have_content("Status: Cancelled")
            end
            expect(page).to_not have_content("Name: Floopy Geo")
        end

        it 'shows the total revenue from all items on invoice' do

          visit "/merchants/#{@merch1.id}/invoices/#{@invoice1.id}"
          
          expect(page).to have_content("Total Revenue: 58000")
        end

        it 'will be able to update item on a merchants invoice' do
          visit "/merchants/#{@merch1.id}/invoices/#{@invoice1.id}"

          expect(page).to have_content("Status:")
          within "#invoice-item-#{@item3.id}" do
            select "shipped", :from => "status"
            click_button "Update Item Status"
          end

          expect(current_path).to eq("/merchants/#{@merch1.id}/invoices/#{@invoice1.id}")
          expect(page).to have_content("Status: shipped")
        end

    end

end
