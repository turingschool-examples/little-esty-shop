require 'rails_helper' 

RSpec.describe 'Merchant Dashboard' do 
    # Merchant Dashboard
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it 'has the name of the Merchant' do 
        merchant_1 = Merchant.create!(name: 'Mike Dao')
        merchant_2 = Merchant.create!(name: 'Dani Coleman')

        visit "merchants/#{merchant_1.id}/dashboard" 
        save_and_open_page

        expect(page).to have_content('Mike Dao')
        expect(page).to_not have_content('Dani Coleman')
    end
end