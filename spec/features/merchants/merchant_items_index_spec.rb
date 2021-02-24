require "rails_helper"

RSpec.describe "Merchant Items Index Page" do
  describe "When I visit my merchant items index page (merchant/merchant_id/items)" do
    it "I see a list of the names of all of my items" do
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


        visit "/merchant/#{merchant.id}/items"

        within("#merchant-items") do
          expect(page).to have_content(item1.name)
          expect(page).to have_content(item2.name)
          expect(page).to have_content(item3.name)
          expect(page).to_not have_content(item4.name)
        end
      end
    end
end

# And I do not see items for any other merchant
