require "rails_helper"

RSpec.describe "merchant discount show page", type: :feature do
  describe "as a merchant" do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @discount1 = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)
      # @discount2 = @merchant.discounts.create!(discount_percentage: 15, threshhold_quantity: 8)
      # @discount3 = @merchant.discounts.create!(discount_percentage: 10, threshhold_quantity: 5)

      visit "/merchants/#{@merchant.id}/discounts/#{@discount1.id}"
    end

    it "I see the discount's quantity and discount percentage" do
      expect(page).to have_content("Discount #{@discount1.id} --- Quantity: #{@discount1.threshhold_quantity} units, Discount: #{@discount1.discount_percentage}%")
    end

    it "I can edit the discount" do
      click_on "Edit This Discount"

      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")

      fill_in "Discount percentage", with: "30"
      fill_in "Threshhold quantity", with: "40"
      click_on "Update Discount"
      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}")
      expect(page).to have_content("Discount #{@discount1.id} --- Quantity: 40 units, Discount: 30%")
    end
  end
end
