require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature  do

  before :each do 
    @merchant = Merchant.create!(name: "dude")
  end

  describe ' As a Merchant ' do 
    describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)' do
      # User story 1
      it "Then I see the name of my merchant " do
        visit merchant_dashboard_index_path(@merchant.id)
       

        expect(current_path).to eq("/merchant/#{@merchant.id}/dashboard")
        expect(page).to have_content(@merchant.name)
      end 
      # user story 2
      it "Then I see link to my merchant items index (/merchants/merchant_id/items)" do 
        visit merchant_dashboard_index_path(@merchant.id)

        expect(page).to have_button("My Items")
        click_button "My Items"
        expect(current_path).to eq("/merchant/#{@merchant.id}/items")
      end
      it "And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        visit merchant_dashboard_index_path(@merchant.id)

        expect(page).to have_button("My Invoices")
        click_button "My Invoices"
        expect(current_path).to eq("/merchant/#{@merchant.id}/invoices")
      end
    end 
  end
end