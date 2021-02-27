require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items/item_id/edit'" do
  before :each do
      @merchant1 = create(:merchant)
      @item = create(:item, merchant_id: @merchant1.id)
  end

  describe "It has a form to update the item" do
    it "Has exisiting attribute information as placeholders" do
      visit edit_merchant_item_path(@merchant1, @item)

      expect(find_field(:name).value).to eq(@item.name)
      expect(find_field(:description).value).to eq(@item.description)
      expect(find_field(:unit_price).value).to eq("#{@item.unit_price.to_f}")
    end
    it "returns to item show page with updated info" do
      visit edit_merchant_item_path(@merchant1, @item)

      fill_in 'name', with: "New Name"
      fill_in 'description', with: 'a thing'
      fill_in 'unit_price', with: 100.00

      click_on "Update Item"

      expect(current_path).to eq(merchant_item_path(@merchant1, @item))
      expect(page).to have_content("New Name")
      expect(page).to have_content("100.0")
      expect(page).to have_content("a thing")
      expect(page).to have_content("Item Succesfully Updated")
    end
    it "Shows required info missing if field is blank" do
      visit edit_merchant_item_path(@merchant1, @item)

      fill_in 'name', with: " "
      fill_in 'description', with: 'a thing'
      fill_in 'unit_price', with: 100.00

      click_on "Update Item"

      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item))
      expect(page).to have_content("Required Information Missing")
    end
  end
end
