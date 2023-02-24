require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")
    
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  describe "User story 1" do
    describe "When I visit my merchant dashboard" do
      it "As a merchant, when I visit my merchant dashboard 
        (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do

        expect(page).to have_content("Trader Bob's")
      end
    end
  end

  describe "User story 2" do
    describe "When I visit my merchant dashboard" do
      it "shows a link to my merchant items index (/merchants/merchant_id/items)" do
       
        expect(page).to have_link("Items", href: "/merchants/#{@merchant.id}/items")
      end

      it "show a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        
        expect(page).to have_link("Invoices", href: "/merchants/#{@merchant.id}/invoices")
      end
    end
  end

  describe "User story 3" do
    describe "When I visit my merchant dashboard" do
      it "I see the names of the top 5 customers who have conducted 
        the largest number of successful transactions with my merchant" do
       
        expect(page).to have_content("customer1_name")
        expect(page).to have_content("customer2_name")
        expect(page).to have_content("customer3_name")
        expect(page).to have_content("customer4_name")
        expect(page).to have_content("customer5_name")
        expect(page).to_not have_content("customer6_name")
      end

      it "next to each customer name I see the number of successful transactions they have
        conducted with my merchant" do
        
        expect(page).to have_content("customer1_transactions")
        expect(page).to have_content("customer2_transactions")
        expect(page).to have_content("customer3_transactions")
        expect(page).to have_content("customer4_transactions")
        expect(page).to have_content("customer5_transactions")
        expect(page).to_not have_content("customer6_transactions")
      end
    end
  end
end