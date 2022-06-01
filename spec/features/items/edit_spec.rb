require 'rails_helper'

RSpec.describe 'item edit page' do 

  it 'can edit an item' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500 )
    
    visit edit_merchant_item_path(merchant_1.id, item_1.id)

    fill_in 'name', with: "Dangly Earings"
    fill_in 'description', with: 'They tickle your neck.'
    fill_in 'unit_price', with: '2000'
    click_button 'Update Item'

    expect(current_path).to eq(merchant_item_path(merchant_1.id, item_1.id))
    expect(page).to have_content("$20.00")
  end 
end