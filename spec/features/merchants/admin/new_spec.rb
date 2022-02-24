require 'rails_helper'

RSpec.describe 'admin merchant new form' do
    it 'Admin Merchant Create' do 
        merchant_1 = create(:merchant)
        merchant_4 = create(:merchant, status: 1)
        
        visit '/admin/merchants/new'
        
        expect(page).to have_content("New Merchant")

        fill_in 'name', with: "Arch City Apparel"
        click_button("Submit")
        expect(current_path).to eq("/admin/merchants/")
        
        within ".enabled" do 
            expect(page).to have_content(merchant_1.name)
            expect(page).to_not have_content("Arch City Apparel")
        end

        within ".disabled" do 
            expect(page).to have_content("Arch City Apparel")
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Enable", count: 2)
            expect(page).to_not have_content(merchant_1.name)
        end
    end
end
