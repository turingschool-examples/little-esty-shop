#need to do my form test here, grab the info from previous tests. then create form on new.html you goddamnstoner
require 'rails_helper'

RSpec.describe "merchant item creation" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
  end

    it "can create a new merchant item using a form" do
      visit new_merchant_item_path(@merchant_1)

      fill_in(:name, with: 'Slinky')
      fill_in(:description, with: 'Toy')
      fill_in(:unit_price, with: 10)

      click_button('Submit')
      save_and_open_page
      # expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content("Slinky")

      #left off on new spec. getting error for line 24
    end
  end
