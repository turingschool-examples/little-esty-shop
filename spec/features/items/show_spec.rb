require 'rails_helper'

describe 'Merchant item show page' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)

    visit merchant_item_path(@merchant1, @item1)
  end

  describe 'display' do
    it 'all attributes for one item' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.unit_price)
      expect(page).to have_content(@item1.description)
    end

    it 'includes a link to update item info' do
      click_link "Update Item Information"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
    end
  end
end
