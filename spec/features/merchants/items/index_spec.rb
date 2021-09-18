require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  context 'When I visit my merchant items index page' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1     = create(:item, merchant: @merchant_1) # cookies
      @item_2     = create(:item, merchant: @merchant_1, name: "crackers", status: "Enabled")
      @item_3     = create(:item, merchant: @merchant_1, name: "biscuits")

      @merchant_2 = create(:merchant)
      @item_4     = create(:item, merchant: @merchant_2, name: "watermelon")

      visit "/merchants/#{@merchant_1.id}/items"
    end

    it 'lists the names of all my items' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
    end

    it 'i do not see items for any other merchant' do
      expect(page).to_not have_content(@item_4.name)
    end

    it 'links to the merchant items show page from each item name' do
      click_link("#{@item_1.name}")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

      visit "/merchants/#{@merchant_1.id}/items"
      click_link("#{@item_2.name}")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}")

      visit "/merchants/#{@merchant_1.id}/items"
      click_link("#{@item_3.name}")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_3.id}")
    end

    it 'has a button for enable when item is disabled' do
      within "#item-#{@item_1.id}" do
        expect(page).to     have_button('Enable')
        expect(page).to_not have_button('Disable')

        click_button('Enable')
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      end
    end

    it 'has a button for disable when item is enabled' do
      within "#item-#{@item_2.id}" do
        expect(page).to     have_button('Disable')
        expect(page).to_not have_button('Enable')

        click_button('Disable')
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      end
    end
  end
end
