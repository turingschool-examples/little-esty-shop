require 'rails_helper'

RSpec.describe "Merchant Item Create New" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end
#   As a merchant
# When I visit my items index page
# I see a link to create a new item.
# When I click on the link,
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.
  describe 'user story 11' do
    it 'I see a link to create a new item am taken to a form that allows me to add item' do

      visit merchant_items_path(@merchant_1)

      click_button "Create New Item"
      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
    end

    it 'I fill out the form I click Submit I see the item I just created as disabled' do

      visit new_merchant_item_path(@merchant_1)

      fill_in "item[name]", with: "Hat"
      fill_in "item[description]", with: "Orange"
      fill_in "item[unit_price]", with: "1000"
      click_on "Create Item"

      expect(current_path).to eq(merchant_items_path(@merchant_1))

      within("#disabled-items") do
        expect(page).to have_content("Hat")
      end
    end
  end
end
