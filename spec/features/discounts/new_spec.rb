require "rails_helper"

RSpec.describe("Discounts New Page") do
  before(:each) do
    @merchant = create(:merchant)
    visit(new_merchant_discount_path(@merchant))
  end
  describe 'When I visit /merchants/:merchant_id/discounts/new' do
    describe 'Then I see' do
      it 'a form to create a new discount' do
        within "#discounts-form-#{@merchant.id}" do
          expect(find('form')).to have_content('Item Threshold:')
          expect(find('form')).to have_content('Discount:')
        end
      end

      describe 'When I fill out the form' do
        context 'given valid data' do
          it 'I am taken to the discount index page and see the new discount listed' do
            within "#discounts-form-#{@merchant.id}" do
              fill_in :quantity_threshold, with: 20
              fill_in :percentage_discount, with: 50
              click_button 'Submit'
            end
            expect(current_path).to eq(merchant_discounts_path(@merchant.id))
            expect(page).to have_content("Item threshold # 20, Amount Discounted 50%")
          end
        end
        context 'given invalid data' do
          it 'I am taken to the discount new page and see a flash message' do
            within "#discounts-form-#{@merchant.id}" do
              fill_in :percentage_discount, with: 50
              click_button 'Submit'
            end
            expect(current_path).to eq(new_merchant_discount_path(@merchant.id))
            expect(page).to have_content("Error: Quantity threshold can't be blank")
          end
        end
      end
    end
  end
end