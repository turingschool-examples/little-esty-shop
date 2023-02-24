require 'rails_helper'

describe 'Admin Merchants index page' do
  describe 'As an admin' do
    describe 'When I visit the admin merchants index (/admin/merchants)' do
      it "Then I see the name of each merchant in the system" do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        visit admin_merchants_path
      
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end

      it "I see a link to create a new merchant. When I click I am taken to a form that allows me to add merchant information.When I fill out the form I click ‘Submit’ Then I am taken back to the admin merchants index page And I see the merchant I just created displayed And I see my merchant was created with a default status of disabled. " do

        visit admin_merchants_path
        click_link('Create a new merchant')

        expect(current_path).to eq(new_admin_merchant_path)
        expect(page).to have_content("Create a New Merchant")
        expect(page).to have_field("Name")

        fill_in("Name", with: 'All the Shoes')
        click_button("Submit")
       
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content('All the Shoes')
      end
    end
  end
end