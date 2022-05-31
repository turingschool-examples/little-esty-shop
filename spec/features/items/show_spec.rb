require 'rails_helper'

RSpec.describe 'merchant item show page' do 

  it 'shows all item attributes' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500 )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999 )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999 )
    
    merchant_2 = Merchant.create(name: "Antique's by Annie")
    item_4 = merchant_2.items.create!(name: "1920's Driving Gloves" , description: 'Leather' , unit_price: 2999 )
   
    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content("$15.00")
  end
end