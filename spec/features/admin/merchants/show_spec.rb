require 'rails_helper'

RSpec.describe 'admin merchant show page' do 

     it 'shows you can click on a link to edit a merchant and be redirected to the edit page' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        
        visit "/admin/merchants/#{merchant_1.id}"

        expect(page).to have_content("#{merchant_1.name}")

        click_on("Update #{merchant_1.name}")

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
    end 
end 