require 'rails_helper'


RSpec.describe 'Merchant Invoice Show Page' do
  before do
    @merch1 = FactoryBot.create(:merchant)
    @cust1 = FactoryBot.create(:customer)
    @item1 = FactoryBot.create(:item, merchant_id: @merch1.id)
    @item2 = FactoryBot.create(:item, merchant_id: @merch1.id)
    @item3 = FactoryBot.create(:item, merchant_id: @merch1.id)
    @invoice1 = FactoryBot.create(:invoice, created_at: Time.now, customer_id: @cust1.id)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)

  end
  describe 'As a visitor' do

    it 'I see the invoices id, status, formated created at date, customer first and last name' do

      visit "/merchants/#{@merch1.id}/invoices/#{@invoice1.id}"
      save_and_open_page
      expect(page).to have_content("Invoice ID: #{@invoice1.id}")
      expect(page).to have_content("Status: #{@invoice1.status}")
      expect(page).to have_content("Created At: #{@invoice1.formatted_created_at}")
      expect(page).to have_content("Customer Name: #{@invoice1.customer_name}")


    end



  end
end
