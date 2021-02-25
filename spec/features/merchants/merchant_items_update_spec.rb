require "rails_helper"

RSpec.describe "Merchant Item Update" do
  describe "When I visit the merchant show page of an item" do
    it "I see a link to update the item information." do
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

      visit "/merchant/#{merchant.id}/items/#{item1.id}"

      within("#update-link") do
        expect(page).to have_link("Update Item")

        click_link("Update Item")

        expect(current_path).to eq("/merchant/#{merchant.id}/items/#{item1.id}/edit")
      end
    end
    it "I can update the item information using a form." do
      merchant = Merchant.create(name: "John's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 4599.95)

      visit "/merchant/#{merchant.id}/items/#{item1.id}/edit"

      within(".item-form") do
        fill_in("item[name]", with: "Diamond Ring")
        fill_in("item[description]", with: "Shine like diamonds")
        fill_in("item[unit_price]", with: 5000.00)
      end
      click_button("Update")

      expect(current_path).to eq("/merchant/#{merchant.id}/items/#{item1.id}")
      expect(page).to have_content("Item Successfully Updated")
      expect(page).to have_content("Diamond Ring")
      expect(page).to have_content("Shine like diamonds")
      expect(page).to have_content(5000.00)
    end
  end
end
