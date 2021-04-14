require 'rails_helper'

RSpec.describe 'As a visitor' do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)
    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  describe 'I visit a merchant dashboard' do
    it "Then I see the name of my merchant" do
      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'merchant dashboard links' do
    it "to merchant invoices index" do
      expect(page).to have_content("Merchant Invoices Index")

      click_link("Merchant Invoices Index")
      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices")
    end
  end

  describe 'merchant dashboard links' do
    it "to merchant items index" do
      expect(page).to have_content("Merchant Items Index")

      click_link("Merchant Items Index")

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
    end
  end

  describe 'merchant dashboard' do
    it "displays names of top 5 customers by number of succussful transactions" do
      expect(page).to have_content("Top 5 Customers")
      # expect(page).to have_content(@merchant_1.item.invoice_item.invoices.customer)

    end
  end
end
