require 'rails_helper'

RSpec.describe 'Item index page', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Willms and Sons')
    @item1 = @merchant1.items.create!(name: 'Item 1', description: 'An item', unit_price: 1300)
    @item2 = @merchant1.items.create!(name: 'Item 2', description: 'Another item', unit_price: 1200)
    @item3 = @merchant2.items.create!(name: 'Item 3', description: 'Another other item', unit_price: 1240)

    visit "/merchants/#{@merchant1.id}/items"
  end

  describe 'merchant item index page' do
    it 'shows a merchants items' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end

    it 'links to create items page' do
      click_on 'New Item'

      expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/new")
    end

    it 'lets you click on the disabled button' do
      within("#item-#{@item1.id}") do
        click_button 'Disable'
      end

      expect(@item1.reload.status).to eq('disabled')
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end

    it 'lets you click on the enable button' do
      within("#item-#{@item2.id}") do
        click_button 'Enable'
      end

      expect(@item2.reload.status).to eq('enabled')
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end
  end
end
