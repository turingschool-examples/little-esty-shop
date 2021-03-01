require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit a merchant's item's show page" do
    before :each do
      @merchant_1 = Merchant.create!(name: 'One')
      @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
      @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
      # @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Three Description', unit_price: 30)

      visit merchant_item_path(@merchant_1.id, @item_2.id)
    end

    it "I see all of the item's attributes" do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content("Description: #{@item_2.description}")
      expect(page).to have_content("Price: #{@item_2.unit_price}")
    end

    it 'shows a link to update the item information.' do
      expect(page).to have_link('Edit Item Information')
    end

    describe "When I click the link" do
      it 'I am taken to a page to edit this item' do
        click_link('Edit Item Information')

        expect(current_path).to eq(edit_merchant_item_path(@merchant_1.id, @item_2.id))
      end
    end
  end
end
