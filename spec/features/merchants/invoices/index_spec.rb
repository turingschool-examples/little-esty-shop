require 'rails_helper'

RSpec.describe 'Merchant Invoice Index Page' do
  context 'when i visit my merchant invoice index page' do
    before :each do
      @merchant_1 = create(:merchant)
      @item_1     = create(:item, merchant: @merchant_1) # cookies
      @item_2     = create(:item, merchant: @merchant_1, name: "crackers", status: "Enabled")
      @item_3     = create(:item, merchant: @merchant_1, name: "biscuits")
      @item_5     = create(:item, merchant: @merchant_1, name: "wafers", status: "Enabled")
      @customer_1 = create(:customer)
      @customer_2 = create(:customer, first_name: "Betty", last_name: "Sue")
      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_1, status: 1)
      @invoice_3 = create(:invoice, customer: @customer_1, status: 2)

      @merchant_2 = create(:merchant)
      @item_4     = create(:item, merchant: @merchant_2, name: "watermelon")

      create(:invoice_item, item: @item_1, invoice: @invoice_1)
      create(:invoice_item, item: @item_4, invoice: @invoice_2)
      create(:invoice_item, item: @item_3, invoice: @invoice_3)

      visit "/merchants/#{@merchant_1.id}/invoices"
    end

    it 'lists all invoices that include at least one of my merchants items' do
      expect(page).to have_content("Invoice: #{@invoice_1.id}")
      expect(page).to have_content("Invoice: #{@invoice_3.id}")
      expect(page).to_not have_content("Invoice: #{@invoice_2.id}")
    end
  end
end