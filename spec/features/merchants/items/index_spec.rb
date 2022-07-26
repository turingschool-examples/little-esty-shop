require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do 
    it 'can click on the name of an item and be redirected to that merchants items show page' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
        spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
        
        expect(page).to have_link('Spatula')
        expect(page).to have_link('Spoon')

        click_on('Spatula')

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{spatula.id}")
    end
end