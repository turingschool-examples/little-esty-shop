require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard' do 
    xit 'has the name of the merchant' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content('Spongebob The Merchant')
        expect(page).to_not have_content('Jon Doe')
    end
end 