require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id, enabled: true)
    @item2 = create(:item, merchant_id: @merchant1.id, enabled: true)
    @item3 = create(:item, merchant_id: @merchant1.id, enabled: false)

    visit "/merchants/#{@merchant1.id}/items"
  end

  it 'shows each item has a default status of enabled' do
    within("#item-#{@item1.id}") do
      expect(page).to have_button('Disable')
    end

    within("#item-#{@item2.id}") do
      expect(page).to have_button('Disable')
    end

    within("#item-#{@item3.id}") do
      expect(page).to have_button('Enable')
    end
  end

  it 'shows that enabled item can have status changed to disabled by clicking button' do
    within("#item-#{@item1.id}") do
      expect(page).to have_button('Disable')

      click_button 'Disable'

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      expect(page).to have_button('Enable')
    end
  end

  it 'shows that disabled item can have status changed to enabled by clicking button' do
    within("#item-#{@item3.id}") do
      expect(page).to have_button('Enable')

      click_button 'Enable'

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      expect(page).to have_button('Disable')
    end
  end
end
