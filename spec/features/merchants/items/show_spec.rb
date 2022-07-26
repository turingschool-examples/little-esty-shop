require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do 
    it 'has all the items attributes' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
        spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
        
        visit "/merchants/#{merchant_1.id}/items/#{spatula.id}"

        expect(page).to have_content('Spatula')
        expect(page).to have_content('It is for cooking')
        expect(page).to have_content('Current selling price is: 3')
    end
end