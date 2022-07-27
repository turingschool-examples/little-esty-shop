require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do 
  it 'has all the items attributes' do 
    merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
    merchant_2 = Merchant.create!(name: 'Jon Doe')

    spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
    spatula_2 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 2, merchant_id: merchant_2.id)
    spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
    
    visit "/merchants/#{merchant_1.id}/items/#{spatula.id}"

    expect(page).to have_content('Spatula')
    expect(page).to have_content('Item Description: It is for cooking')
    expect(page).to have_content('Current selling price is: $3.00')
    expect(page).to_not have_content(spatula_2.unit_price)
  end

  it 'links to a specific items edit page' do
    merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
    
    spatula = merchant_1.items.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3)

    visit "/merchants/#{merchant_1.id}/items/#{spatula.id}"

    expect(page).to have_link('Edit Spatula')
  end
end