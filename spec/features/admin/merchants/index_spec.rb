require 'rails_helper'

RSpec.describe "Admin Merchant Index" do
    before :each do
        @merch1 = Merchant.create!(name: 'Floopy Fopperations')
        @merch2 = Merchant.create!(name: 'A-Team')
        @merch3 = Merchant.create!(name: 'Blue Clues')
        @merch4 = Merchant.create!(name: 'Apple Bottom Jeans')
    end

    describe "Admin Merchant Index" do
        it "displays the name of all merchants in the system" do
            visit "/admin/merchants"
            expect(page).to have_content("Floopy Fopperations") 
            expect(page).to have_content("A-Team") 
            expect(page).to have_content("Blue Clues") 
            expect(page).to have_content("Apple Bottom Jeans") 
        end
    end
    
end