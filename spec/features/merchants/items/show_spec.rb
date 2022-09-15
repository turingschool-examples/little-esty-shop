require 'rails_helper'

RSpec.describe 'Merchant Item Show Page: ' do
  before :each do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1, unit_price: 5700)
    @item2 = create(:item, merchant: @merch1)

    @merch2 = create(:merchant)
    @item3 = create(:item, merchant: @merch2)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
  end

  describe 'As a merchant' do
    describe 'when I visit the merchant show page of an item' do

      it 'when item link is clicked, merchant is taken to item index page' do
        visit merchant_items_path(@merch1.id)

        click_link "#{@item2.name}"

        expect(current_path).to eq(merchant_item_path(@merch1.id, @item2.id))
      end

      it 'item show page lists item attributes' do
        visit merchant_item_path(@merch1.id, @item1.id)

        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content("Current Selling Price: $57.00")
save_and_open_page
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
      end

      it 'there is a link to update the item information' do
        visit merchant_item_path(@merch2.id, @item4.id)

        expect(page).to have_link("Update #{@item4.name}")
      end
    end
  end
end