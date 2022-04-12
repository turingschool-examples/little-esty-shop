require 'rails_helper'


RSpec.describe 'Merchant Invoice Show Page' do

  describe 'As a visitor' do

    it 'I see the invoices id, status, formated created at date, customer first and last name' do
      merch1 = FactoryBot.create(:merchant)
      cust1 = FactoryBot.create(:customer)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      item2 = FactoryBot.create(:item, merchant_id: merch1.id)
      item3 = FactoryBot.create(:item, merchant_id: merch1.id)
      invoice1 = FactoryBot.create(:invoice, created_at: Time.now, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

      visit "/merchants/#{merch1.id}/invoices/#{invoice1.id}"
      # save_and_open_page
      expect(page).to have_content("Invoice ID: #{invoice1.id}")
      expect(page).to have_content("Status: #{invoice1.status}")
      expect(page).to have_content("Created At: #{invoice1.formatted_created_at}")
      expect(page).to have_content("Customer Name: #{invoice1.customer_name}")
    end

    it 'I see ONLY items that are mine and those items attributes' do
      merch1 = FactoryBot.create(:merchant)
      merch2 = FactoryBot.create(:merchant)
      cust1 = FactoryBot.create(:customer)
      item1 = FactoryBot.create(:item, merchant_id: merch1.id)
      item2 = FactoryBot.create(:item, merchant_id: merch1.id)
      item3 = FactoryBot.create(:item, merchant_id: merch1.id)
      item4 = FactoryBot.create(:item, merchant_id: merch2.id)

      invoice1 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      invoice_item_2 = FactoryBot.create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id)
      invoice_item_3 = FactoryBot.create(:invoice_item, item_id: item3.id, invoice_id: invoice1.id)
      invoice_item_4 = FactoryBot.create(:invoice_item, item_id: item4.id, invoice_id: invoice1.id)

      visit "/merchants/#{merch1.id}/invoices/#{invoice1.id}"
      # require "pry"; binding.pry
      expect(page).to have_content("My Items on This Invoice:")
      save_and_open_page
      within "#invoice_item-#{invoice_item_1.id}" do
        expect(page).to have_content("Item Name: #{item1.name}")
        expect(page).to have_content("Quantity Ordered: #{invoice_item_1.quantity}")
        expect(page).to have_content("Item Price: #{invoice_item_1.unit_price}")
        expect(page).to have_content("Invoice Item Status: #{invoice_item_1.status}")
      end
      within "#invoice_item-#{invoice_item_2.id}" do
        expect(page).to have_content("Item Name: #{item2.name}")
        expect(page).to have_content("Quantity Ordered: #{invoice_item_2.quantity}")
        expect(page).to have_content("Item Price: #{invoice_item_2.unit_price}")
        expect(page).to have_content("Invoice Item Status: #{invoice_item_2.status}")
      end
      within "#invoice_item-#{invoice_item_3.id}" do
        expect(page).to have_content("Item Name: #{item3.name}")
        expect(page).to have_content("Quantity Ordered: #{invoice_item_3.quantity}")
        expect(page).to have_content("Item Price: #{invoice_item_3.unit_price}")
        expect(page).to have_content("Invoice Item Status: #{invoice_item_3.status}")
      end

      expect(page).to_not have_content("#{item4.name}")
      expect(page).to_not have_content("#{invoice_item_4.unit_price}")

    end

  end
end
