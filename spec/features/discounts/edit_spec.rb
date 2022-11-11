require "rails_helper"

RSpec.describe("Discounts Edit Page") do
  before(:each) do
    @merchant = create(:merchant)
    @discount_1 = create(:discount, merchant: @merchant, quantity_threshold: 30, percentage_discount: 40)
    visit(edit_merchant_discount_path(@merchant, @discount_1))
  end

  describe 'When I visit /merchants/:merchant_id/discounts/:id/edit' do
    describe 'Then I see' do
      it 'the discounts current threshold and amount' do
        within "#discount-edit-form-#{@merchant.id}" do
          expect(page).to have_field(:quantity_threshold, with: @discount_1.quantity_threshold)
          expect(page).to have_field(:percentage_discount, with: @discount_1.percentage_discount)
        end
      end
    end

    describe 'When I change any/all of the information and click "Submit"' do
      context 'given valid data' do
        it 'I am taken to the discount index page and see the new discount listed' do
          within "#discount-edit-form-#{@merchant.id}" do
            fill_in :quantity_threshold, with: 20
            fill_in :percentage_discount, with: 50
            click_button 'Submit'
          end
          expect(current_path).to eq(merchant_discount_path(@merchant, @discount_1))
          expect(page).to have_content("Item threshold # 20, Amount Discounted 50%")
        end
      end

      context 'given invalid data' do
        it 'I am taken to the discount new page and see a flash message' do
          within "#discount-edit-form-#{@merchant.id}" do
            fill_in :quantity_threshold, with: ''
            fill_in :percentage_discount, with: 50

            click_button 'Submit'
          end
          expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount_1))
          expect(page).to have_content("Error: Quantity threshold can't be blank")
        end
      end
    end
  end
end