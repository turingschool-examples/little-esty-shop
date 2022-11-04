require "rails_helper"

RSpec.describe "the merchant items edit page" do
  describe "As a merchant when I visit the merchant item show page and click on the update item link" do
    it "takes me to a merchan item edit page with field already filled out, when I submit the form i'm redirected to the show page where i see my edits" do
      merchant = Merchant.create!(name: "Practical Magic Shop")
      book = merchant.items.create!(name: "Book of the dead", description: "book of necromancy spells", unit_price: 4)

      visit "/merchants/#{merchant.id}/items/#{book.id}"
      click_on("Update Item")

      expect(current_path).to eq(edit_merchant_item_path(merchant, book))
      expect(page).to have_field("name", with: "Book of the dead")
      expect(page).to have_field("description", with: "book of necromancy spells")
      expect(page).to have_field("unit_price", with: "4")
      expect(page).to have_button("Submit")

      fill_in("name", with: "Dead Spells Book")
      fill_in("description", with: "This is a hundred year old tome full of necromancy spells. Very rare.")
      click_button("Submit")

      expect(current_path).to eq(merchant_item_path(merchant, book))
      expect(page).to have_content("Dead Spells Book")
      expect(page).to have_content("Description: This is a hundred year old tome full of necromancy spells. Very rare.")
      expect(page).to have_content("Current Price: $4.00")
      within "#flash-messages" do
        expect(page).to have_content("This item's information has been successfully updated!")
      end
    end
  end
end