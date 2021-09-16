require 'rails_helper'
# as a merchant,
# When I visit my merchant items index page ("merchant/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
RSpec.describe 'Merchant Items Index page' do
  context 'When I visit my merchant items index page' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_1)

      @merchant_2 = create(:merchant, id: 2)
      @item_4 = create(:item, merchant: @merchant_2, name: "Watermelon")

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
  end
end