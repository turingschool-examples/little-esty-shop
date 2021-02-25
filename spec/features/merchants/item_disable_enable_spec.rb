require "rails_helper"

RSpec.describe "Merchant Item Disable/Enable" do
  describe "When I visit my items index page" do
    it "Next to each item I see a button to disable or enable that item" do
      merchant = Merchant.create(name: "John's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 599.95)
      item2 = merchant.items.create(name: "Pearl Necklace", description: "Beautiful White Pearls",
                                    unit_price: 250.00)
      item3 = merchant.items.create(name: "Diamond Earrings", description: "Sparkly studs",
                                    unit_price: 300.00)
      item4 = merchant.items.create(name: "Mood Ring", description: "Check Your Mood of the Day!",
                                    unit_price: 150.00)

      visit "merchant/#{merchant.id}/items"

      within("#merchant-items") do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("Disabled Items")
        expect(page).to have_link(item1.name)
        expect(page).to have_link(item2.name)
        expect(page).to have_link(item3.name)
        expect(page).to have_link(item4.name)
        expect(page).to have_button("Disable")
      end

      within("#item-#{item1.id}", match: :first) do
        click_button("Disable")

        expect(current_path).to eq("/merchant/#{merchant.id}/items")
      end

      expect(page).to have_content("Disabled Items")
      expect(item2.name).to appear_before(item1.name)
      expect(item3.name).to appear_before(item1.name)
      expect(item1.name).to_not appear_before(item4.name)
    end
  end
end
