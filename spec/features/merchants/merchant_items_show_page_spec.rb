require "rails_helper"

RSpec.describe "Merchant Items Show Page" do
  describe "When I click on the name of an item from the merchant items index page," do
    it "Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)" do
      merchant = Merchant.create(name: "John's Jewelry")
      merchant2 = Merchant.create(name: "Brian's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 4599.95)
      item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                    unit_price: 650.00)
      item3 = merchant.items.create(name: "Diamond Earrings", description: "Sparkly studs",
                                    unit_price: 300.99)
      item4 = merchant2.items.create(name: "Mood Ring", description: "Check Your Mood of the Day!",
                                    unit_price: 150.00)

      visit "/merchant/#{merchant.id}/items"

      click_link("Gold Ring", match: :first)

      expect(current_path).to eq("/merchant/#{merchant.id}/items/#{item1.id}")

    end
    it "And I see all of the item's attributes including: Name, Description, Current Selling Price" do
      merchant = Merchant.create(name: "John's Jewelry")
      merchant2 = Merchant.create(name: "Brian's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 599.95)
      item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                    unit_price: 250.00)
      item3 = merchant.items.create(name: "Diamond Earrings", description: "Sparkly studs",
                                    unit_price: 300.00)
      item4 = merchant2.items.create(name: "Mood Ring", description: "Check Your Mood of the Day!",
                                    unit_price: 150.00)

      visit "/merchant/#{merchant.id}/items/#{item1.id}"

      expect(page).to have_content(item1.name)

      within("#item-info") do
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.unit_price)
        expect(page).to_not have_content(item2.name)
      end
    end
  end
end
