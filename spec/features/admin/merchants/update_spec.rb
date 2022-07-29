require 'rails_helper'

RSpec.describe 'admin merchant update page' do 

    it 'allows you to update a merchant and return to the merchant show page' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        
        visit "/admin/merchants/#{merchant_1.id}/edit" 
        expect(page).to have_content("#{merchant_1.name}")

        within "#merchant_edit_name" do 
            expect(page).to have_field('merchant[name]', with: merchant_1.name)
        end 

        fill_in("Name", with: "")
        click_on("Update")
        
        expect(page).to have_content("Error: name can't be blank")

        fill_in("Name", with: "Batman")
        click_on("Update")

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
        expect(page).to have_content("Batman")
        expect(page).to have_content("Your merchant has been updated.")
    end 
end 