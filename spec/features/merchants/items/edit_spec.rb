require "rails_helper"

RSpec.describe "the merchant items edit page" do 
  # I see a link to update the item information.
  # When I click the link
  # Then I am taken to a page to edit this item
  # And I see a form filled in with the existing item attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the item show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.
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