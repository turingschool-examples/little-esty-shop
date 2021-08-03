require 'rails_helper'

RSpec.describe 'the merchant invoice show' do

  describe 'display' do
    it 'shows header text merchant name and invoice id' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#header') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_content("Invoice ##{@invoice1.id}")
      end
    end

    it 'shows status, created on, and total revenue' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#invoice_info') do
        expect(page).to have_content("Status: #{@invoice1.status}")
        expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Total Revenue: $787.00")
      end
    end

    it 'shows customer header and name' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#customer') do
        expect(page).to have_content('Customer:')
        expect(page).to have_content("#{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
      end
    end

    it 'shows all items on invoice and their attributes' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#items') do
        expect(page).to have_content('Items on this Invoice:')

        within("#item-#{@item1.id}") do
          expect(page).to have_content("Item Name: #{@item1.name}")
          expect(page).to have_content("Quantity: #{@invoice_item1.quantity}")
          expect(page).to have_content("Unit Price: #{@invoice_item1.unit_price}")
          expect(page).to have_select('invoice_item[status]', selected: @invoice_item1.status)
        end

        within("#item-#{@item2.id}") do
          expect(page).to have_content("Item Name: #{@item2.name}")
          expect(page).to have_content("Quantity: #{@invoice_item15.quantity}")
          expect(page).to have_content("Unit Price: #{@invoice_item15.unit_price}")
          expect(page).to have_select('invoice_item[status]', selected: @invoice_item15.status)
        end

        within("#item-#{@item3.id}") do
          expect(page).to have_content("Item Name: #{@item3.name}")
          expect(page).to have_content("Quantity: #{@invoice_item16.quantity}")
          expect(page).to have_content("Unit Price: #{@invoice_item16.unit_price}")
          expect(page).to have_select('invoice_item[status]', selected: @invoice_item16.status)
        end
      end
    end

    it 'does not show item info not on invoice' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      expect(page).to_not have_content(@item4.name)
      expect(page).to_not have_content(@item5.name)
      expect(page).to_not have_content(@item8.name)
      expect(page).to_not have_content(@item10.name)
    end
  end

  describe 'forms' do
    it 'can select a new status, submit form, and see the updated status' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within("#item-#{@item1.id}") do
        expect(@invoice_item1.status).to_not eq('pending')

        page.select 'pending', from: 'invoice_item[status]'
        click_button 'Update Item Status'
      end

      expect(current_path).to eq(merchant_invoice_path(@merchant1.id, @invoice1.id))

      within("#item-#{@item1.id}") do
        updated_invoice_item = InvoiceItem.find(@invoice_item1.id)

        expect(updated_invoice_item.status).to eq('pending')

        expect(page).to have_select('invoice_item[status]', selected: 'pending')
      end
    end
  end
end
