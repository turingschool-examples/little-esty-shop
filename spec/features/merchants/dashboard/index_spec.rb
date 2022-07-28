require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do

  before :each do
    @merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
  end

  describe "I visit a merchant dashboard" do
    it 'displays the merchant name' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content(@merchant.name)
    end

    it 'as a merchant it displays a link to the my merchant index items page' do
      visit merchant_dashboard_index_path(@merchant)
      
      expect(page).to have_link("My Items Index")

      click_link("My Items Index")

      expect(page).to have_current_path(merchant_items_path(@merchant))
    end 

    it "opens my invoice from dashboard index page" do 
      visit "/merchants/#{@merchant.id}/dashboard"
      
      expect(page).to have_link("My Invoices Index")

      click_link("My Invoices Index")

      expect(page).to have_current_path(merchant_invoices_path(@merchant))
    end
  end
end
