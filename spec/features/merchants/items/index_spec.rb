require "rails_helper"

RSpec.describe "On the Merchant's Items index page" do 
  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  describe "When I visit merchants/:merchant_id/items" do 
    it "displays a list of the names of all my items and I do not see items for any other merchant" do 
      merchant = Merchant.create!(name: "Practical Magic Shop")
      book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
      candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
      potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10)

      other_merchant = Merchant.create!(name: "Joe's Pickle Bus")
      other_merchant.items.create!(name: "Fried pickles", description: "a packet of fried pickles", unit_price: 2)
      other_merchant.items.create!(name: "Pickled cabbage", description: "a packet of pickled cabbage", unit_price: 1)

      visit "/merchants/#{merchant.id}/items"
      save_and_open_page 
      
      within "#item-#{book.id}" do 
        expect(page).to have_content("Book of the dead")
      end
      within "#item-#{candle.id}" do 
        expect(page).to have_content("Candle of life")
      end
      within "#item-#{potion.id}" do 
        expect(page).to have_content("Love potion")
      end

      expect(page).to_not have_content("Fried pickles")
      expect(page).to_not have_content("Pickled cabbage")
    end
  end

  describe "Wireframe requirements for merchants items index page" do 
    it "has the little esty shop heading, nav bar, My Items header, and merchant's name" do
      merchant = Merchant.create!(name: "Practical Magic Shop")

      visit "merchants/#{merchant.id}/items"

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content("Practical Magic Shop")
      expect(page).to have_content("Dashboard")
      expect(page).to have_content("My Items")
      expect(page).to have_content("Invoices")
      expect(page).to have_content("My Items")
    end 
  end
end