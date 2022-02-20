require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item = @merchant.items.create!(name: 'tem Qui Esse', description: 'nihil autem', unit_price: 75107)
  end

  it 'has a prepopulated form of respective item' do
    visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    expect(page).to have_field('Name', with: 'tem Qui Esse')
    expect(page).to have_field('Description', with: 'nihil autem')
    expect(page).to have_field('Unit price', with: '75107')
  end

   it 'can edit country attributes and redirect' do
     visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
     click_button("Submit")

     expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item.id}")
   end

end
