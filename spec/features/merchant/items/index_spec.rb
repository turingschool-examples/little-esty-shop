require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1, enabled: false)
    @item_5 = create(:item, merchant: @merchant_1, enabled: false)

    visit merchant_items_path(@merchant_1.id)
  end

  describe 'Merchant Items Index Page (User Story 6)' do
    it 'has a header' do
      expect(page).to have_content("#{@merchant_1.name} Items")
    end

    it 'it lists all of the merchant item names as links' do
      visit merchant_items_path(@merchant_1)

      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
      end
    end

    it 'does not display items from any other merchant' do
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)

      expect(page).to_not have_link(item_2.name)
    end
  end

  describe 'Merchant Item Disable/Enable (User Story 9)' do
    it 'has a button next to each item for enabling or disabling that item' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'

        expect(page).to have_button('Enable Item')
      end
      expect(page).to have_content("#{@merchant_1.name} Items")
    end

    it 'enabling or disabling a button changes its enabled status in the database' do
      expect(@item_1.enabled).to eq(true)
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'
      end
      expect(@item_1.reload.enabled).to eq(false)
    end

    it 'displays a flash message that the item has been successfully enabled or disabled ' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'
      end
      expect(page).to have_content("Item successfully disabled!")

      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Enable Item')

        click_button 'Enable Item'
      end
      expect(page).to have_content("Item successfully enabled!")
    end
  end

  describe 'Merchant Items Grouped by Status (User Story 10)' do
    it 'displays a section for "Enabled Items" and "Disabled Items"' do
      expect(page).to have_content("Enabled Items")
      expect(page).to have_content("Disabled Items")
    end

    it 'displays only the enabled items in the "Enabled Items" section' do
      within "#enabled-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to_not have_content(@item_4.name)
        expect(page).to_not have_content(@item_5.name)
      end
    end

    it 'displays only the disabled items in the "Disabled Items" section' do
      within "#disabled-items" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
      end
    end
  end
end
