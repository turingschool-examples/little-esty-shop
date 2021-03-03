require 'rails_helper'
RSpec.describe 'When I visit the admin merchants index (/admin/merchants)' do
  describe 'Then I see the names of the top 5 merchants by total revenue generated' do
    before (:each) do
      @customer_1 = create(:customer, first_name: "Minnie")
      @customer_2 = create(:customer, first_name: "Lloyd")
      @customer_3 = create(:customer, first_name: "Hector")
      @customer_4 = create(:customer, first_name: "Andrea")
      @customer_5 = create(:customer, first_name: "Fred")
      @customer_6 = create(:customer, first_name: "Payton")
      @customer_7 = create(:customer, first_name: "7")
      @invoice_1 = create(:invoice, status: 'completed', customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, status: 'completed', customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, status: 'completed', customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, status: 'completed', customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, status: 'completed', customer_id: @customer_5.id)
      @invoice_6 = create(:invoice, status: 'completed', customer_id: @customer_6.id)
      @invoice_7 = create(:invoice, status: 'completed', customer_id: @customer_7.id)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1)
      @item_2 = create(:item, merchant: @merchant_2, unit_price: 2)
      @item_3 = create(:item, merchant: @merchant_3, unit_price: 3)
      @item_4 = create(:item, merchant: @merchant_4, unit_price: 4)
      @item_5 = create(:item, merchant: @merchant_5, unit_price: 5)
      @item_6 = create(:item, merchant: @merchant_6, unit_price: 6)
      @item_7 = create(:item, merchant: @merchant_7, unit_price: 7)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1, status: 2)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, unit_price: 2, status: 2)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, unit_price: 3, status: 2)
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, unit_price: 4, status: 2)
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, unit_price: 5, status: 2)
      @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_6.id, unit_price: 6, status: 2)
      @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_7.id, unit_price: 7, status: 2)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 'success')
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 'success')
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 'success')
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 'failed')
    end
    it 'And I see the total revenue generated next to each merchant name' do
      visit "/admin/merchants"
      save_and_open_page
      within("#top-five") do
        expect(page).to have_content(@merchant_7.name)
        expect(page).to have_content("revenue: 7")
        expect(page).to have_content(@merchant_6.name)
        expect(page).to have_content("revenue: 6")
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content("revenue: 5")
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content("revenue: 4")
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content("revenue: 3")
      end
    end
  end
end