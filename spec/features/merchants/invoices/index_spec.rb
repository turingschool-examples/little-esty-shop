require 'rails_helper'

describe 'merchants invoices index' do
  describe 'invoices' do
    
    before do
      @merchant_1 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_1.id)
      @item_3 = create(:item, merchant_id: @merchant_1.id)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, status: 'completed', created_at: "January 28, 2019")
      @invoice_2 = create(:invoice, customer_id: @customer_1.id, status: 'completed', created_at: "March 27, 2019")
      @invoice_3 = create(:invoice, customer_id: @customer_1.id, status: 'completed', created_at: "April 20, 2019")
      @invoice_4 = create(:invoice, customer_id: @customer_1.id, status: 'completed', created_at: "April 20, 2019")
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, quantity: 10, unit_price: 10, invoice_id: @invoice_1.id )
      @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, quantity: 10, unit_price: 8, invoice_id: @invoice_2.id )
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, quantity: 10, unit_price: 6, invoice_id: @invoice_3.id )
      visit merchant_invoices_path(@merchant_1)
    end

    it 'should have each of the invoices with a merchant\'s item' do
      expect(page).to_not have_content("Id: #{@invoice_4.id}")
      expect(page).to have_content("Id: #{@invoice_1.id}")
      expect(page).to have_content("Id: #{@invoice_2.id}")
      expect(page).to have_content("Id: #{@invoice_3.id}")
    end

    it 'each id links to the merchant invoice show page' do
      click_link @invoice_1.id.to_s
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    end
  end
end