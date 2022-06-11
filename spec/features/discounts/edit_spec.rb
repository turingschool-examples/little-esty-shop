require 'rails_helper'

RSpec.describe "Merchant Discount Edit Page" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  # Merchant Bulk Discount Edit
  #
  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated

  it "displays a discount's pertentage and quantity threshold", :vcr do
    visit edit_merchant_discount_path(merchant1.id, discount1.id)

    expect(find_field('Percentage Discount:').value).to eq('20')

    fill_in 'Percentage Discount:', with: '30'
    fill_in 'Quantity Threshold:', with: '30'
    click_button "Update"

    expect(current_path).to eq(merchant_discount_path(merchant1.id, discount1.id))
    expect(page).to have_content("30% Discount")
    expect(page).to have_content("Quantity: 30")
    expect(page).to_not have_content("20% Discount")
    expect(page).to_not have_content("Quantity: 10")
  end
end
