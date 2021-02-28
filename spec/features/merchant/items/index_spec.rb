require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit my merchant items index page ('merchant/merchant_id/items')" do
    before :each do
      @merchant_1 = Merchant.create!(name: 'One')
      @merchant_2 = Merchant.create!(name: 'Two')
      @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
      @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
      @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Three Description', unit_price: 30)

      visit merchant_items_path(@merchant_1)

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

    describe 'When I click on the name of an item' do
      it "Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)" do
        visit merchant_items_path(@merchant_1)

        expect(page).to have_link(merchant_item_path(@merchant_1.id, @item_1.id))
        # expect(page).to have_link(merchant_item_path(@merchant_1.id, @item_2.id))

        click_link(@item_1.name)

        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_2.id))
      end
    end
  end
end
