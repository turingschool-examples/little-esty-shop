require 'rails_helper'

RSpec.describe 'Merchant#dashboard' do
  describe 'dashboard' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_4 = create(:item, merchant: @merchant_2)
      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021" )
      @invoice_2 = create(:invoice, customer: @customer_1, created_at: "Thursday, September 16, 2021")
      @invoice_3 = create(:invoice, customer: @customer_1, created_at: "Wednesday, September 15, 2021")
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "packaged")
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, status: "shipped")
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_2, status: "packaged")
    end

    it "has a merchant name" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end

    it "lists a link to the items index" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      click_link 'Items Index'
      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it 'lists a link to the invoices index' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      click_link 'Invoices Index'
      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    end

    it 'shows items ready to ship section' do
      visit "/merchants/#{@merchant_1.id}/dashboard"
save_and_open_page
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.date)
      expect(@item_1.name).to appear_before(@item_2.name)
    end
  end
end
