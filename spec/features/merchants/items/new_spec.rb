require 'rails_helper'

RSpec.describe 'create item' do
  before :each do
    @merchant_1 = Merchant.first
  end

  it 'creates a new item' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_button 'New Item'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")

    fill_in 'Name', with: 'New Item'
    fill_in 'Description', with: 'Test'
    fill_in 'Unit price', with: 10
    click_on 'Create Item'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_content('New Item')
  end
end
