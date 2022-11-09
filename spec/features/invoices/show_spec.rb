require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'Honey Bee', status: 'enabled')

    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('19.07.18'))
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2010-03-11 01:51:45')

    InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'packaged', item_id: @item2.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 50, unit_price: 800, status: 'shipped', item_id: @item3.id, invoice_id: @invoice2.id)
  end

  describe 'As a merchant' do
    describe "When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)" do
      it "Then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at date in the format 'Monday, July 18, 2019', Customer first and last name" do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

        expect(page).to have_content("ID: #{@invoice1.id}")
        expect(page).to have_content("Status: #{@invoice1.status}")
        expect(page).to have_content('Created: Thursday, July 18, 2019')
        expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
      end

      it 'Then I see all of my items on the invoice including: Item name, The quantity of the item ordered, The price the Item sold for, The Invoice Item status, And I do not see any information related to Items for other merchants' do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

        within("#item-#{@item2.id}") do
          expect(page).to have_content("Name: #{@item2.name}")
          expect(page).to have_content("Price: #{@item2.unit_price}")
          expect(page).to have_content('Quantity: 15')
          expect(page).to have_content('Status: packaged')
        end

        within("#item-#{@item1.id}") do
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
          expect(page).to have_content('Total Invoice Revenue: 2000¢')
        end
      end

      it 'has a select field with current status that can be changed to update status' do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

        within("#item-#{@item1.id}") do
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

        within("#item-#{@item2.id}") do
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
