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
      # save_and_open_page
      expect(current_path).to eq(merchant_items_path(@merchant1))

      within("#item-#{@item.id}") do
        expect(page).to have_button("Enable Item")
      end
    end
  end
end
# As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed
