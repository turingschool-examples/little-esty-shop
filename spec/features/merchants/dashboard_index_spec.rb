require 'rails_helper'

RSpec.describe "Merchant Dashboard Index" do
  describe "As a merchant" do
    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
  
    before do
      visit "/merchants/#{merchant1.id}/dashboards"
    end
  
    # 1. Merchant Dashboard
    context "When I visit /merchants/merchant_id/dashboard" do
      it "Then I see the name of my merchant" do
        expect(page).to have_content("Name: #{merchant1.name}")
        expect(page).to_not have_content(merchant2.name)
      end
      
      # 2. Merchant Dashboard Links
      it "Then I see link to my merchant items index (/merchants/merchant_id/items)" do 
        expect(page).to have_link("Items")
      end
      
      it "Then I see a link to my merchant invoices index (/merchants/merchant_id/invoices)" do 
        expect(page).to have_link("Invoices")
      end
    end
  end
end