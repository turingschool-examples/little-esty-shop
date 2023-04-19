require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id,status: 'In Progress')
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 50, unit_price: 50)

    visit '/'
  end

  describe "Unsplash API: App Logo" do
    it "displays the logo on every page" do
      expect(page).to have_selector("#logo_img")
      visit merchant_dashboard_path(@merchant_1.id)
      expect(page).to have_selector("#logo_img")
      visit merchant_items_path(@merchant_1.id)
      expect(page).to have_selector("#logo_img")
      visit new_merchant_item_path(@merchant_1.id)
      expect(page).to have_selector("#logo_img")
      visit merchant_invoices_path(@merchant_1.id)
      expect(page).to have_selector("#logo_img")
      visit merchants_path(@merchant_1.id)
      expect(page).to have_selector("#logo_img")
      visit admin_path
      expect(page).to have_selector("#logo_img")
      visit admin_merchants_path
      expect(page).to have_selector("#logo_img")
      visit admin_invoices_path
      expect(page).to have_selector("#logo_img")
    end

    it 'displays the logo likes on every page' do
      expect(page).to have_content("Likes: 111")
    end
  end
end
