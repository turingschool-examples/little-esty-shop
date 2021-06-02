require 'rails_helper'

RSpec.describe 'The index page for an merchants items,' do
  describe 'list of items,' do
    it 'shows only the merchants items' do
      merchant_1 = FactoryBot.create(:merchant)
      merchant_2 = FactoryBot.create(:merchant)
      item_1 = FactoryBot.create(:item, merchant: merchant_1)
      item_2 = FactoryBot.create(:item, merchant: merchant_1)
      item_3 = FactoryBot.create(:item, merchant: merchant_1)
      item_4 = FactoryBot.create(:item, merchant: merchant_2)

      visit merchant_items_path(merchant_1)

      within "#item-#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.unit_price)
        expect(page).to have_content(item_1.quanity)
      end
      within "#item-#{item_2.id}" do
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_2.unit_price)
        expect(page).to have_content(item_2.quanity)
      end
      within "#item-#{item_3.id}" do
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_3.unit_price)
        expect(page).to have_content(item_3.quanity)
      end
    end
  end
  
end
