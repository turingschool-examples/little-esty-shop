require 'rails_helper'

describe 'new merchant item form' do
  before do
    @merchant1 = Merchant.create!(name: 'Long Hair Dont Care')

    visit "merchants/#{@merchant1.id}/items/new"
  end

  it 'has a form for a new item' do
    fill_in 'Name', with: 'Shampoo Bar'
    fill_in 'Description', with: 'Cleans your hair and reduces plastic'
    fill_in 'Unit Price', with: 5
    click_button 'Submit'

    expect(current_path).to eq(merchant_items_path(@merchant1))
    expect(page).to have_content('Shampoo Bar')
  end
end
