require "rails_helper"

RSpec.describe "Merchant Item Create" do
  describe "When I visit my items index page" do
    it "I see a link to create a new item and my item was created with a default status of disabled" do
      merchant = Merchant.create(name: "John's Jewelry")
      item1 = merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
                                    unit_price: 4599.95, status: "Active")

      visit "/merchant/#{merchant.id}/items"

      within("#new-item") do
        expect(page).to have_link("New Item")

        click_link("New Item")
      end
      expect(current_path).to eq("/merchant/#{merchant.id}/items/new")

      within(".item-form") do
        fill_in("item[name]", with: "Diamond Ring")
        fill_in("item[description]", with: "Shine like diamonds")
        fill_in("item[unit_price]", with: 5000.00)

        click_button("Submit")
      end

      expect(current_path).to eq("/merchant/#{merchant.id}/items")


      within("#merchant-items") do
        expect(page).to have_content("Diamond Ring")
        expect(item1.name).to appear_before("Diamond Ring")
      end
    end

    it "displays an error if there are missing fields" do
      merchant = Merchant.create(name: "John's Jewelry")

      visit "/merchant/#{merchant.id}/items/new"

      click_button("Submit")

      expect(page).to have_content("Fields Missing: Fill in all fields")
    end
  end
end
