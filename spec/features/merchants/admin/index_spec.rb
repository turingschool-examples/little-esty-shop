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

        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_button("Disable", count: 3)
        
        expect(page).to have_content(merchant_4.name)
        expect(merchant_4.status).to eq("disabled")
        expect(page).to have_button("Enable", count: 1)
        
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants/")
        
        
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_button("Disable", count: 4)
        expect(page).to_not have_button("Enable")
    end

    it 'Admin Merchants Grouped by Status' do 
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
    
    it 'Admin Merchant Create' do 
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)         
        merchant_4 = create(:merchant, status: 1)
        
        visit '/admin/merchants/'
        
        expect(page).to have_link("New Merchant")
        expect(page).to_not have_content("Arch City Apparel")
        click_link("New Merchant")
        expect(current_path).to eq("/admin/merchants/new")

        fill_in 'name', with: "Arch City Apparel"
        click_button("Submit")
        expect(current_path).to eq("/admin/merchants/")
        
        within ".disabled" do 
            expect(page).to have_content("Arch City Apparel")
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Enable", count: 2)
            expect(page).to_not have_content(merchant_1.name)
        end
    end
end