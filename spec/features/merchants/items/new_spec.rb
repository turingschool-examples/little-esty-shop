require "rails_helper"

RSpec.describe "the New Merchant Item page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Practical Magic Shop")
    @book = @merchant.items.create!(name: "Book of the dead", description: "book of necromancy spells", unit_price: 4)
    @candle = @merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
  end

  describe "As a merchant when I visit the merchants/:id/items there's a link to create a new item" do
    describe "When I click on the link it takes me a to a form to create a new item" do
      it "the form has fields for name, description, unit_price, when I click submit I'm redirected back to the index where I see the new item" do
        visit merchant_items_path(@merchant)

        expect(page).to_not have_content("Love Potion")

        click_on("New Item")

        expect(current_path).to eq(new_merchant_item_path(@merchant))
        expect(page).to have_field("name")
        expect(page).to have_field("description")
        expect(page).to have_field("unit_price")

        fill_in("name", with: "Love Potion")
        fill_in("description", with: "One serving size of true love potion.")
        fill_in("unit_price", with: "10")
        click_on("Submit")

        expect(current_path).to eq(merchant_items_path(@merchant))
        within "#disabled" do
          expect(page).to have_content("Love Potion")
        end
      end

      it "defaults new items to being disabled" do
        visit new_merchant_item_path(@merchant)
        fill_in("name", with: "Love Potion")
        fill_in("description", with: "One serving size of true love potion.")
        fill_in("unit_price", with: "10")
        click_on("Submit")

        expect(@merchant.items.last.status).to eq("disabled")
      end
    end
  end
end