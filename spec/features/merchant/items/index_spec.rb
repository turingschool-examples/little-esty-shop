require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit my merchant items index page ('merchant/merchant_id/items')" do
    before :each do
      @max = Merchant.create!(name: 'Merch Max')
      @bob = Merchant.create!(name: 'Bob')
      @item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
      @item_2 = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
      @item_3 = @bob.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)

      visit "merchants/#{@max.id}/items"
    end

    it 'I see a list of the names of all of my items' do
      within '.merchant-items' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end
    end

    it 'I do not see items for any other merchant' do
      within '.merchant-items' do
        expect(page).to_not have_content(@item_3.name)
      end
    end
  end
end
