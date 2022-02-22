require 'rails_helper'

RSpec.describe 'admin merchant show' do
    it 'shows name of merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        
        visit "/admin/merchants/#{merchant_1.id}"
        
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_3.name)
    end
    
    it 'has a link to update merchant info and directs to merchant update page' do 
        merchant_1 = create(:merchant)
        
        visit "/admin/merchants/#{merchant_1.id}"
        
        click_link("Update Merchant")
        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
        
        within("#form") do 
            expect(page).to have_button("Submit")
        end

        fill_in 'name', with: "Arch City Apparel"
        click_button("Submit")
        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

        expect(page).to have_content("Arch City Apparel")
        expect(page).to have_content("Successfully Updated")
    end
end