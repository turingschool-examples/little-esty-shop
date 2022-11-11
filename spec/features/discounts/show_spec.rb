require "rails_helper"

RSpec.describe("Discounts Show Page") do
  before(:each) do
    @merchant = create(:merchant)
    @discount_1 = create(:discount, merchant: @merchant, quantity_threshold: 30, percentage_discount: 30)
    @discount_2 = create(:discount, merchant: @merchant, quantity_threshold: 50, percentage_discount: 50)
    visit(merchant_discount_path(@merchant, @discount_1))
  end
  describe 'When I visit /merchants/:merchant_id/discounts/:id' do
    describe 'Then I see' do
      it 'the discounts threshold and amount' do
        within "#discount-info-#{@merchant.id}" do
          expect(page).to have_content(@discount_1.quantity_threshold)
          expect(page).to have_content(@discount_1.percentage_discount)

          expect(page).to_not have_content(@discount_2.quantity_threshold)
          expect(page).to_not have_content(@discount_2.percentage_discount)
        end
      end

      it 'a link to edit the discount' do
        within "#discount-edit-#{@merchant.id}" do
          expect(page).to have_link("Edit Discount")
        end
      end
    end
    describe 'When I click on "Edit Discount'
      it 'I am taken to an edit page' do
        within "#discount-edit-#{@merchant.id}" do
          click_link("Edit Discount")

          expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount_1))
        end
      end
  end
end