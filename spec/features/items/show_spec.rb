require 'rails_helper'

RSpec.describe "Merchant Item Show Page" do
  before(:each) do
    @merchant = create(:merchant)

    @item = create(:item, merchant: @merchant)
  end

  describe "As a merchant" do
    describe "From the Merchant Item Index Page" do
      describe "When I click on the name of an item from the merchant items index page" do
        it "takes me to that merchant's item's show page" do
          visit merchant_items_path(@merchant)

          expect(page).to have_link("#{@item.name}")
          click_link("#{@item.name}")
          expect(current_path).to eq(merchant_item_path(@merchant, @item))
        end
      end
    end
    
    it "shows all of the item's attributes: name, description, current selling price" do
      visit merchant_item_path(@merchant, @item)

      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.unit_price)
    end
  end
end