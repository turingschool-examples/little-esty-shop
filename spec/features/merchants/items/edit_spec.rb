require 'rails_helper'

RSpec.describe "The Merchant Item edit page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Korbanth')
    @item1 = @merchant1.items.create!(
      name: 'SK2',
      description: "Starkiller's lightsaber from TFU2 promo trailer",
      unit_price: 25_000,
    )
    @item2 = @merchant1.items.create!(
      name: 'Shtok eco',
      description: "Hilt side lit pcb",
      unit_price: 1_500,
    )
  end

  describe "Merchant Item Update" do
    # As a merchant,
    # I see a form filled in with the existing item attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.

    it "displays a form filled in with the existing item attribute information" do
      visit edit_merchant_item_path(@item1.merchant_id, @item1.id)

      expect(page).to have_field('Name', with: @item1.name)
      expect(page).to have_field('Description', with: @item1.description)
      expect(page).to have_field('Unit price', with: @item1.unit_price)
      expect(page).to_not have_field('Name', with: @item2.name)
      expect(page).to_not have_field('Description', with: @item2.description)
      expect(page).to_not have_field('Unit price', with: @item2.unit_price)
    end

    it "updates submitted are displayed on the item show page along with a flash message confirming the update" do
      visit merchant_item_path(@item1.merchant_id, @item1.id)

      expect(page).to have_content('SK2')
      expect(page).to_not have_content("Item successfully updated.")

      visit edit_merchant_item_path(@item1.merchant_id, @item1.id)

      fill_in('Name', with: 'New Name')
      click_on('Update Item')

      expect(current_path).to eq(merchant_item_path(@item1.merchant_id, @item1.id))
      expect(page).to_not have_content('SK2')
      expect(page).to have_content('New Name')
      expect(page).to have_content("Item successfully updated.")
    end
  end
end
