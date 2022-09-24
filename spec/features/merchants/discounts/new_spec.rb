require 'rails_helper'

RSpec.describe 'bulk discounts index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @discounts = create_list(:discount, 5, merchant: @pretty_plumbing)
  end

#   As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
  describe 'user story 2-solo' do
    it 'I see a link to create a new discount am taken to a form that allows me to add discount' do

      visit merchant_discounts_path(@pretty_plumbing)

      click_button "Create a New Discount"
      expect(current_path).to eq(new_merchant_discount_path(@pretty_plumbing))
    end

    it 'I fill out the form I click Submit I see the discount I just created in the discounts index' do

      visit new_merchant_discount_path(@pretty_plumbing)

      fill_in "discount[bulk_discount]", with: 0.50
      fill_in "discount[item_threshold]", with: 10
      click_on "Create Discount"

      expect(current_path).to eq(merchant_discounts_path(@pretty_plumbing))
    end
  end
end
