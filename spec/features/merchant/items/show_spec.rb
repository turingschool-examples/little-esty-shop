require 'rails_helper'

RSpec.describe 'Merchant Item Show Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, name: "Cat", merchant: @merchant_1)
    @item_2 = create(:item, name: "Dog", merchant: @merchant_1)
    @item_3 = create(:item, name: "Assumenda Animi", merchant: @merchant_1)

    visit merchant_item_path(@merchant_1.id, @item_1)
  end

  describe 'Merchant Item Show Page (User Story 7)' do
    it 'has a header with a link back to the merchant dashboard' do
      expect(page).to have_content("#{@merchant_1.name} Item Details")
      expect(page).to have_link(@merchant_1.name)
    end

    it 'it has a link to the merchant item index' do
      expect(page).to have_link("Items Index")

      click_link("Items Index")

      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
    end

    it 'displays the details of the item' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Current Unit Price: $#{@item_1.unit_price.fdiv(100)}")
    end
  end

  describe 'Item Image (API User Story 2)' do
    it 'displays a photo related to that items name' do

      within "#item-image" do
        expect(page).to have_css('img')
      end

      visit merchant_item_path(@merchant_1, @item_2)

      within "#item-image" do
        expect(page).to have_css('img')
      end
    end

    it 'displays an expected failure image when no photos match the search by item name' do
      visit merchant_item_path(@merchant_1, @item_3)

      within "#item-image" do
        expect(page).to have_css('img')
      end
    end
  end
end
