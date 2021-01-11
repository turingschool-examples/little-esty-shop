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

    describe 'When I click on the name of an item' do
      it "Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)" do
        expect(page).to have_link(@item_1.name, href: "/merchants/#{@max.id}/items/#{@item_1.id}")
        expect(page).to have_link(@item_2.name, href: "/merchants/#{@max.id}/items/#{@item_2.id}")

        click_link(@item_1.name)

        expect(current_path).to eq("/merchants/#{@max.id}/items/#{@item_1.id}")
      end
    end

    it 'Next to each item name I see a button to disable or enable that item' do
      expect(page).to have_selector("input[id='disable-merchant-item-#{@item_1.id}-btn']")
      expect(page).to have_selector("input[id='disable-merchant-item-#{@item_2.id}-btn']")
    end

    describe 'When I click this button' do
      before :each do
        within ".merchant-item-#{@item_1.id}" do
          click_on 'Disable'
        end
      end

      it 'Then I am redirected back to the items index' do
        expect(current_path).to eq(merchant_items_path(@max.id))
      end

      it 'Then I see that the items status has changed' do
        within ".merchant-item-#{@item_1.id}" do
          expect(page).to have_content("Status: Disabled")
          expect(page).to have_button("Enable")

          click_on 'Enable'

          expect(page).to have_content("Status: Enabled")
          expect(page).to have_button("Disable")
        end
      end
    end
  end
end
