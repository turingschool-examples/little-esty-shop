require 'rails_helper'

RSpec.describe 'bulk discount show page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 20)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_1, discount: 0.10, threshold: 15)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant_1, discount: 0.05, threshold: 12)

    @bulk_discount_4 = create(:bulk_discount, merchant: @merchant_2, discount: 0.45, threshold: 30)
    @bulk_discount_5 = create(:bulk_discount, merchant: @merchant_2, discount: 0.30, threshold: 20)
    @bulk_discount_6 = create(:bulk_discount, merchant: @merchant_2, discount: 0.20, threshold: 10)
  end

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount

  describe 'User Story 4 - When I visit my bulk discount show page' do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
      visit  merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      within "#bulk-discount-info" do
        expect(page).to have_content(@bulk_discount_1.discount)
        expect(page).to have_content(@bulk_discount_1.threshold)
        expect(page).to_not have_content(@bulk_discount_2.discount)
        expect(page).to_not have_content(@bulk_discount_2.threshold)
      end

      visit  merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)
      
      within "#bulk-discount-info" do
        expect(page).to have_content(@bulk_discount_4.discount)
        expect(page).to have_content(@bulk_discount_4.threshold)
        expect(page).to_not have_content(@bulk_discount_5.discount)
        expect(page).to_not have_content(@bulk_discount_5.threshold)
      end
    end
  end 
end