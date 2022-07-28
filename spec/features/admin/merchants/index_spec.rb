require 'rails_helper' 
require 'faker' 
require 'pry'

RSpec.describe 'Admin Merchants Index' do 
    # Admin Merchants Index
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    it 'shows the name of each merchant in the system' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name)

        visit '/admin/merchants' 
        # save_and_open_page

        within('#merchant-0') do 
            expect(page).to have_content(merchant_1.name)
        end

        within('#merchant-1') do 
            expect(page).to have_content(merchant_2.name)
        end

        within('#merchant-2') do 
            expect(page).to have_content(merchant_3.name)
        end

        within('#merchant-3') do 
            expect(page).to have_content(merchant_4.name)
        end
    end
end