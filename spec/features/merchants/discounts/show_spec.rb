require 'rails_helper'

RSpec.describe 'Merchant Discount Show' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @discounts = create_list(:discount, 5, merchant: @pretty_plumbing)
    @discounts_1 = create_list(:discount, 5, merchant: @merchant_1)

  end
#   As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount
  describe 'user story 4-solo' do
    it 'I see the bulk discounts quantity threshold and percentage discount' do
      visit merchant_discount_path(@merchant_1, @discounts_1[2])

      within("#discount-#{@discounts_1[2].id}") do
        expect(page).to have_content(@discounts_1[2].id)
        expect(page).to have_content(@discounts_1[2].item_threshold)
        expect(page).to have_content((@discounts_1[2].bulk_discount.round(2))*100)
        expect(page).to_not have_content(@discounts_1[0].id)
      end

      visit merchant_discount_path(@pretty_plumbing, @discounts[2])

      within("#discount-#{@discounts[2].id}") do
        expect(page).to have_content(@discounts[2].id)
        expect(page).to have_content(@discounts[2].item_threshold)
        expect(page).to have_content((@discounts[2].bulk_discount.round(2))*100)
        expect(page).to_not have_content(@discounts[0].id)
      end
    end
  end
end
