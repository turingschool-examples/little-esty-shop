  
require 'rails_helper'
RSpec.describe 'Item show page' do
    before :each do 
        @merchant_1 = Merchant.create!(
            name: "Store Store",
            created_at: Date.current,
            updated_at: Date.current
            )
        @cup = @merchant_1.items.create!(
            name: "Cup",
            description: "What the **** is this thing?",
            unit_price: 10000,
            created_at: Date.current,
            updated_at: Date.current
            )
        visit "/merchants/#{@merchant_1.id}/items"
    end 
  
  it 'has a link to the item show page with the attributes' do
    click_on('Cup')
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@cup.id}")
    expect(page).to have_content('Cup')
    expect(page).to have_content('What the **** is this thing?')
    expect(page).to have_content('100')
  end

  it 'item show page has edit button' do
    visit "/merchants/#{@merchant_1.id}/items/#{@cup.id}"
    expect(page).to have_link('Edit')
  end
  
end 