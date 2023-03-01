require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do

  before do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id, status: 'completed', created_at: "January 28, 2019")
    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, quantity: 10, unit_price: 10, invoice_id: @invoice_1.id )
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, quantity: 10, unit_price: 8, invoice_id: @invoice_1.id )
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, quantity: 10, unit_price: 6, invoice_id: @invoice_1.id )
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  # 15. Merchant Invoice Show Page
  describe "When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)" do
    it "Then I see information related to that invoice" do
      expect(page).to have_content("ID: #{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Created At: Monday, January 28, 2019")
      expect(page).to have_content("Customer: #{@customer_1.first_name} #{@customer_1.last_name}")
    end
  end
end
