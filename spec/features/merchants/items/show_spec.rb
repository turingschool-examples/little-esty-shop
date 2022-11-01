require "rails_helper"

RSpec.describe "On the Merchant's Items show page" do 
  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:
  # - Name
  # - Description
  # - Current Selling Price
  describe "When I visit merchants/:merchant_id/items/:item_id" do 
    it "displays the name, description, and current selling price of the item" do 
      merchant = Merchant.create!(name: "Practical Magic Shop")
      book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
      candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
      
      other_merchant = Merchant.create!(name: "Joe's Pickle Bus")
      other_merchant.items.create!(name: "Fried pickles", description: "a packet of fried pickles", unit_price: 2)

      visit "/merchants/#{merchant.id}/items/#{book.id}" 
      
      expect(page).to have_content("Book of the dead")
      expect(page).to have_content("Description: book of necromamcy spells")
      expect(page).to have_content("Current Price: $4.00")

      expect(page).to_not have_content("Candle of life")
      expect(page).to_not have_content("Description: candle that gifts everlasting life")
      expect(page).to_not have_content("Current Price: $15.00")
    end

    it "displays a link to update the item information, when clicked I am taken to a page to edit the item" do 
      merchant = Merchant.create!(name: "Practical Magic Shop")
      book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)

      visit "/merchants/#{merchant.id}/items/#{book.id}"

      expect(page).to have_link("Update Item", href: edit_merchant_item_path)

      click_on("Update Item")

      expect(current_path).to eq(edit_merchant_item_path)
    end
  end

  describe "Wireframe requirements for merchants items show page" do 
    it "has the little esty shop heading, nav bar, My Items header, and merchant's name" do
      merchant = Merchant.create!(name: "Practical Magic Shop")
      book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)

      visit "merchants/#{merchant.id}/items/#{book.id}"

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content("Practical Magic Shop")
      expect(page).to have_content("Dashboard")
      expect(page).to have_content("My Items")
      expect(page).to have_content("My Invoices")
    end 
  end
end