require 'rails_helper'
describe 'As a merchant' do
  describe "When I visit my merchant's invoice show page '/merchants/merchant_id/invoices/invoice_id'" do
    before :each do
      # Customers:
      @salim     = Customer.create!(first_name: 'Salim', last_name: 'Imwera', address: 'Up The Hill, Kwale, Kenya')
      @sally     = Customer.create!(first_name: 'Sally', last_name: 'Smith', address: 'Test Address')
      # Merchants:
      @amazon    = Merchant.create!(name: 'Amazon')
      @max       = Merchant.create!(name: 'Merch Max')
      @all_birds = Merchant.create!(name: 'Al Birds')
      @happy_cones = Merchant.create!(name: 'Happy Cones')
      # Invoices:
      @invoice1  = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @max.id)
      @invoice2  = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @max.id)
      @invoice5  = Invoice.create!(status: 2, customer_id: @salim.id, merchant_id: @amazon.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
      @invoice6  = Invoice.create!(status: 2, customer_id: @sally.id, merchant_id: @all_birds.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
      @invoice7  = Invoice.create!(status: 2, customer_id: @sally.id, merchant_id: @happy_cones.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
      # Items:
      @item_1    = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
      @item_2    = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
      @item_3    = @max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)
      @backpack  = @amazon.items.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 5.0)
      @radio     = @amazon.items.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 10.0)
      @shoes     = @all_birds.items.create!(name: 'Pink Shoes', description: 'Light and warm booties!', unit_price: 120.0)
      @ice_cream = @happy_cones.items.create!(name: 'Hockey Pokey', description: 'Toffee bits in vanilla ice cream.', unit_price: 3.0)
      # InvoiceItems:
      @invitm1   = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @item_1.id)
      @invitm2   = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @item_2.id)
      @invitm3   = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 10, invoice_id: @invoice1.id, item_id: @item_2.id)
      @invitm4   = InvoiceItem.create!(status: 2, quantity: 50, unit_price: 5.0, invoice_id: @invoice5.id, item_id: @backpack.id)
      @invitm5   = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 10.0, invoice_id: @invoice5.id, item_id: @radio.id)
      @invitm6   = InvoiceItem.create!(status: 1, quantity: 5, unit_price: 10.0, invoice_id: @invoice5.id, item_id: @item_3.id)
      @invitm7   = InvoiceItem.create!(status: 1, quantity: 10, unit_price: 120.0, invoice_id: @invoice6.id, item_id: @shoes.id)
      @invitm8   = InvoiceItem.create!(status: 1, quantity: 4, unit_price: 3.0, invoice_id: @invoice7.id, item_id: @ice_cream.id)
      # Discounts:
      @discount_1 = Discount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @all_birds.id)
      @discount_2 = Discount.create!(discount_percentage: 15, quantity_threshold: 15, merchant_id: @amazon.id)
      @discount_3 = Discount.create!(discount_percentage: 20, quantity_threshold: 10, merchant_id: @amazon.id)
      @discount_4 = Discount.create!(discount_percentage: 20, quantity_threshold: 15, merchant_id: @max.id)
      @discount_5 = Discount.create!(discount_percentage: 30, quantity_threshold: 15, merchant_id: @max.id)
      @discount_1 = Discount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @happy_cones.id)
    end
    it "Then I can see information related to that invoice including id, status, created at" do
          visit merchant_invoice_path(@max, @invoice1)
          expect(page).to have_content(@invoice1.id)
          expect(page).to have_content(@invoice1.status)
          expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
        end
        it "Then I see all of my items on the invoice including: name, quantity, price" do
          visit merchant_invoice_path(@max, @invoice1)
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_1.unit_price)
          expect(page).to have_content(@invitm1.quantity)
        end
        it 'Then I see all of the customer information related to that invoice including: first_name, last_name, shipping address' do
          visit merchant_invoice_path(@max, @invoice1)
          within '.customer-information' do
            expect(page).to have_content("First Name: #{@sally.first_name}")
            expect(page).to have_content("Last Name: #{@sally.last_name}")
            expect(page).to have_content("Address: #{@sally.address}")
          end
        end
        it "Then I see that each invoice item status is a select field and the item's current status is selected" do
          visit merchant_invoice_path(@max, @invoice1)
          expect(page).to have_select('Status:', :options => ['packaged', 'pending', 'shipped'], :selected => 'packaged')
        end
        describe 'When I click this select field' do
          it 'Then I can select a new status for the Item' do
            visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"
            within "#invoice-item-#{@invitm1.id}" do
              select 'pending', from: 'Status:'
              expect(page).to have_button('Update Item Status')
            end
          end
          describe 'When I click this button' do
            it "Then I am taken back to the merchant invoice show page and Item's status has now been updated" do
              visit merchant_invoice_path(@max, @invoice1)
              within "#invoice-item-#{@invitm1.id}" do
                select 'pending', from: 'Status:'
                click_button('Update Item Status')
              end
              expect(current_path).to eq("/merchants/#{@max.id}/invoices/#{@invoice1.id}")
              within "#invoice-item-#{@invitm1.id}" do
                expect(page).to have_select('Status:', :selected => 'pending')
              end
            end
          end
        end
        it 'Then I see the total revenue that will be generated from all of my items on the invoice' do
          expected_revenue = @invitm1.quantity * @invitm1.unit_price + @invitm3.quantity * @invitm3.unit_price

          visit merchant_invoice_path(@max, @invoice1)

          expect(page).to have_content("Total Revenue: $#{(expected_revenue)}")
        end
      describe 'When I visit the merchant invoice show page'do
          it "I see that the total revenue for my merchant includes the discounts in the calculation" do

            visit merchant_invoice_path(@all_birds, @invoice6)

            expect(page).to have_content("Total Discount Revenue: $1140.0")
        end
        it "shows $0 if invoice does not meet discount conditions" do
          visit merchant_invoice_path(@happy_cones, @invoice7)

          expect(page).to have_content("Total Discount Revenue: $0")
        end
        it "Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)" do
# Merchant Invoice Show Page: Link to applied discounts
# As a merchant
# When I visit my merchant invoice show page
            visit merchant_invoice_path(@all_birds, @invoice6)
            save_and_open_page
            # require "pry"; binding.pry
            expect(page).to have_content("Discount ID Used: 2456")
# Next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)
        end
    end
  end
end
