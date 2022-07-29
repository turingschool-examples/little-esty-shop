require 'rails_helper' 

RSpec.describe 'form for new Merchant' do 
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the admin merchants index page
    # And I see the merchant I just created displayed
    # And I see my merchant was created with a default status of disabled.
    it 'can create a new Merchant' do
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        
        merchant_3_name = Faker::Name.unique.name
        visit new_admin_merchant_path

        fill_in('New Merchant Name', with: merchant_3_name)
        click_on 'Create New Merchant' 

        expect(current_path).to eq '/admin/merchants'
        
        within('#enabled') do 
            expect(page).to have_content merchant_1.name
            expect(page).to have_content merchant_2.name
        end

        within('#disabled') do 
            expect(page).to have_content merchant_3_name
        end
    end
end