require 'rails_helper'

RSpec.describe "Bulk Discounts Index Page", type: :feature
  describe 'User Story 2 - Merchant Bulk Discount Create' do
    it "visits the merchants bulk discount and can visit a link to create a new " do
      merchant = create_list(:merchant, 2)

      bulk_discount1 = merchant[0].bulk_discounts.create!(threshold: 10, discount_percentage: 20)
      bulk_discount2 = merchant[0].bulk_discounts.create!(threshold: 15, discount_percentage: 15)

      visit "/merchants/#{merchant[0].id}/bulk_discounts"

    within "#leftSide2" do
      expect(page).to have_link("Create New Discount")

      click_link('Create New Discount')

    end

    expect(current_path).to eq("/merchants/#{merchant[0].id}/bulk_discounts")

    fill_in('threshold', with: 20)
    fill_in('discount_percentage', with: 25)
    click_on 'Submit'

    within "#leftSide2" do
      expect(current_path).to eq(20)
      expect(current_path).to eq(25)
    end
  end
end
