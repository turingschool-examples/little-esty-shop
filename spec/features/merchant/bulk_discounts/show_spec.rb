require 'rails_helper'
RSpec.describe 'The Merchant Bulk Discount Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
    @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                    merchant_id: @merchant1.id)
    @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                  merchant_id: @merchant1.id)
  end

  describe 'bulk discount show page' do
    it "will list a bulk discount' attributes, including percentage discount and quantity thresholds" do
      visit merchant_bulk_discount_path(@merchant1.id, @ten.id)

      expect(page).to have_content(@ten.name)
      expect(page).to have_content(@ten.display_discount)
      expect(page).to have_content(@ten.quantity_threshold)
    end
  end
end
