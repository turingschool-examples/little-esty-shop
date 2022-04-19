require 'rails_helper'

RSpec.describe "Admin Merchant Show" do

    it 'has a link to edit the merchant' do

        @merchant_1 = Merchant.create!(
        name: "Wally World",
        created_at: Date.current,
        updated_at: Date.current)

        visit "/admin/merchants/#{@merchant_1.id}"
        click_link "Edit"
        fill_in "Name", with: "Boat Shop"
        click_button "Update"
        expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
        expect(page).to have_content("INFO HAS BEEN UPDATED!!!!!")


        
    end
    
end
