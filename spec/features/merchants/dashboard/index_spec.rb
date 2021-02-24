require 'rails_helper'

RSpec.describe "Merchant Dashboard" do 
  before(:each) do 
    @merchant = create(:merchant)
  end
  describe "When I vist a merchants dashboard" do 
    it "shows the merchants name and links to items and invoices" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
    end
      it "shows the top 5 customers" do 
        visit "/merchant/#{@merchant.id}/dashboard"

        within "topFive" do 
          expect(page).to have_cotent(@cust1.name)
          expect(page).to have_cotent(@cust2.name)
          expect(page).to have_cotent(@cust3.name)
          expect(page).to have_cotent(@cust4.name)
          expect(page).to have_cotent(@cust5.name)
        end
      end
    xit "and I click on the My Items link it takes me to that merchants items page" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)

      click_on "My Items"

      expect(current_path).to eq("/merchant/#{@merchant.id}/items")
    end
    xit "and I click on the My Invocies link it takes me to that merchants invoices page" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)

      click_on "My Invoices"

      expect(current_path).to eq("/merchant/#{@merchant.id}/invoices")
    end
  end
end