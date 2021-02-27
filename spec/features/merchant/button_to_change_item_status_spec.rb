require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items'" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant2.id)
    @item6 = create(:item, merchant_id: @merchant2.id)
  end

  describe "Next to each item I see a button to disable/enable the item" do
    it "Redirects to items index after clicking, with updated status" do
      visit merchant_items_path(@merchant1)

      within("#item-#{@item.id}") do
        expect(page).to have_button("Disable Item")
        click_button "Disable Item"
      end

      expect(page).to have_content("#{@item.name} Disabled")
      expect(current_path).to eq(merchant_items_path(@merchant1))

      within("#item-#{@item.id}") do
        expect(page).to have_button("Enable Item")
        click_button "Enable Item"
      end

      expect(page).to have_content("#{@item.name} Enabled")

      within("#item-#{@item.id}") do
        expect(page).to have_button("Disable Item")
      end
    end
  end
end
