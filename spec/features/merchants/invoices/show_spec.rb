require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  describe 'merchant show page - no discounts' do  
    before :each do
      @merchant1 = Merchant.create!(name: 'Marvel')
      @merchant2 = Merchant.create!(name: 'Honey Bee', status: 'enabled')

      @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')

      @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant_id: @merchant2.id)

      @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('19.07.18'))
      @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2010-03-11 01:51:45')

      @invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
      @invoice_item_2 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'packaged', item_id: @item2.id, invoice_id: @invoice1.id)
      @invoice_item_3 = InvoiceItem.create!(quantity: 50, unit_price: 800, status: 'shipped', item_id: @item3.id, invoice_id: @invoice2.id)
    end

    describe 'As a merchant' do
      describe "When I visit my merchant's invoice show page" do
        it "I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at date in the format 'Monday, July 18, 2019', Customer first and last name" do
          visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

          expect(page).to have_content("ID: #{@invoice1.id}")
          expect(page).to have_content("Status: #{@invoice1.status}")
          expect(page).to have_content('Created: Thursday, July 18, 2019')
          expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
        end

        it 'Then I see all of my items on the invoice including: Item name, The quantity of the item ordered, The price the Item sold for, The Invoice Item status, And I do not see any information related to Items for other merchants' do
          visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

          within("#item-#{@invoice_item_2.id}") do
            expect(page).to have_content("Name: #{@item2.name}")
            expect(page).to have_content("Price: #{@item2.unit_price}")
            expect(page).to have_content('Quantity: 15')
            expect(page).to have_content('Status: packaged')
          end

          within("#item-#{@invoice_item_1.id}") do
            expect(page).to have_content("Name: #{@item1.name}")
            expect(page).to have_content("Price: #{@item1.unit_price}")
            expect(page).to have_content('Quantity: 5')
            expect(page).to have_content('Status: packaged')
          end

          expect(page).to_not have_content(@item3.name)
        end

        it 'I see the total revenue that will be generated from all of my items on the invoice' do
          visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

          within('#total_invoice_revenue') do
            expect(page).to have_content('Total Invoice Revenue: 2000')
          end
        end

        it 'has a select field with current status that can be changed to update status' do
          visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

          within("#item-#{@invoice_item_1.id}") do
            expect(page).to have_selector(:css, 'form')
            expect(find('form')).to have_content("#{@item1.invoice_items.first.status}")
            expect(@item1.invoice_items.first.status).to eq('packaged')

            expect(page).to have_button('Update Item Status')

            select('shipped', from: 'Status')
            click_button('Update Item Status')

            expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
            expect(@item1.invoice_items.first.status).to eq('shipped')
            expect(find('form')).to have_content('shipped')
          end

          within("#item-#{@invoice_item_2.id}") do
            expect(page).to have_selector(:css, 'form')
            expect(find('form')).to have_content("#{@item2.invoice_items.first.status}")
            expect(@item2.invoice_items.first.status).to eq('packaged')

            expect(page).to have_button('Update Item Status')

            select('pending', from: 'Status')
            click_button('Update Item Status')

            expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
            expect(@item2.invoice_items.first.status).to eq('pending')
            expect(find('form')).to have_content('pending')

            select('packaged', from: 'Status')
            click_button('Update Item Status')

            expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
            expect(@item2.invoice_items.first.status).to eq('packaged')
            expect(find('form')).to have_content('packaged')
          end
        end
      end
    end
  end

  describe 'merchant bulk discount applied' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
      @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
      
      @discount_1 = BulkDiscount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant_1.id)
      @discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant_1.id)
      @discount_3 = BulkDiscount.create!(percentage: 10, quantity_threshold: 2, merchant_id: @merchant_2.id)
      
      @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
      @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') 
      
      @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('21.01.28'))
      @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.08.22'))
      
      @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant_1.id)
      @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
      
      @invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
      @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
      
      @invoice_item_3 = InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice1.id)
      @invoice_item_4 = InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice2.id)
      
      @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
      @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    end

    it 'has total revenue and discounted revenue for that invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice1)

      within("#total_invoice_revenue") do
        expect(page).to have_content("Total Invoice Revenue: 2500")
        expect(page).to have_content("Total Invoice Revenue with Discounts: 2125.0")
      end
    end

    it 'shows a link to show page for a bulk discount' do
      visit merchant_invoice_path(@merchant_1, @invoice1)

      within("#item-#{@invoice_item_1.id}") do
        expect(page).to have_link("Discount Applied")
      end

      within("#item-#{@invoice_item_3.id}") do
        expect(page).to have_link("Discount Applied")
      end
    end
  end
end
