require 'rails_helper'

RSpec.describe "Bulk Discounts Index Page", type: :feature do
  describe 'User Story 2 - Merchant Bulk Discount Create' do
    it "visits the merchants bulk discount and can visit a link to create a new " do
      merchant = create(:merchant)

      visit merchant_bulk_discounts_path(merchant.id)

    within "#leftSide2" do
      expect(page).to have_link("Create New Discount")

      click_link('Create New Discount')
    end

    expect(current_path).to eq new_merchant_bulk_discount_path(merchant)

    fill_in :threshold, with: 20
    fill_in :discount_percentage, with: 25
    click_on 'Submit New Discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant))

    expect(page).to have_content(20)
    expect(page).to have_content(25)
    end
  end
end
