require 'rails_helper' 
require 'pry'

RSpec.describe 'Admin Merchant Show Page' do 
    # Admin Merchant Update
    # As an admin,
    # When I visit a merchant's admin show page
    # Then I see a link to update the merchant's information.
    # When I click the link
    # Then I am taken to a page to edit this merchant
    it 'has a form to update the Merchant inforation' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name)

        visit admin_merchant_path(merchant_1)

        click_link("Update Merchant Info")

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
    end

    # And I see a form filled in with the existing merchant attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the merchant's admin show page where I see the updated information


    # And I see a flash message stating that the information has been successfully updated.

end