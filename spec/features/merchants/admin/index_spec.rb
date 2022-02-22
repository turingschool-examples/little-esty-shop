require 'rails_helper'

RSpec.describe 'admin merchant index' do
    it 'displays name of each merchant in the system' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        merchant_4 = create(:merchant)

        visit '/admin/merchants'
         
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_content(merchant_4.name)
        expect(page).to_not have_content(merchant_4.id)
    end
        
    it 'Admin Merchant Enable/Disable' do 
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)         
        merchant_4 = create(:merchant, status: 1)
    
        visit '/admin/merchants/'

        within ".enabled" do 
            expect(page).to have_content(merchant_1.name)
            expect(page).to have_content(merchant_2.name)
            expect(page).to have_content(merchant_3.name)
            expect(page).to have_button("Disable", count: 3)
        end
        
        within ".disabled" do 
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Enable", count: 1)
        end
        
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants/")
        
        within ".enabled" do 
            expect(page).to have_content(merchant_1.name)
            expect(page).to have_content(merchant_2.name)
            expect(page).to have_content(merchant_3.name)
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Disable", count: 4)
        end

        within ".disabled" do 
            expect(page).to_not have_content(merchant_4.name)
            expect(page).to_not have_button("Enable", count: 1)
        end
    end
    
end