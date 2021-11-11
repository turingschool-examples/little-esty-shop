require 'rails_helper'

RSpec.describe 'Item index page', type: :feature do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Willms and Sons')
    @merchant_2 = Merchant.create!(name: 'John Jacob Jay')
    @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'An item', unit_price: 1300)
    @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Another item', unit_price: 1200, status: 1)
    @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Another other item', unit_price: 1240)

    visit merchant_items_path(@merchant_1)
  end

  describe 'merchant item index page' do
    it 'shows a merchants items' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    it 'links to create items page' do
      click_on 'New Item'

      expect(page).to have_current_path(new_merchant_item_path(@merchant_1))
    end

    it 'lets you click on the disabled button' do
      within("#item-#{@item_1.id}") do
        click_button 'Disable'
      end

      expect(@item_1.reload.status).to eq('disabled')
      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it 'lets you click on the enable button' do
      within("#item-#{@item_2.id}") do
        click_button 'Enable'
      end

      expect(@item_2.reload.status).to eq('enabled')
      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end
  end
end