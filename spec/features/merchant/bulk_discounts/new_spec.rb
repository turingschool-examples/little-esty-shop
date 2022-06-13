require 'rails_helper'
RSpec.describe 'Merchant create #new bulk discount' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
    @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                    merchant_id: @merchant1.id)
    @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                  merchant_id: @merchant1.id)
  end

  describe 'Merchant Create Bulk Discount page' do
    describe 'bulk discount index page has link to add a new discount' do
      it 'has a new link to add a new discount ' do
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_link('Add new Discount')
        click_link('Add new Discount')
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

        fill_in 'Name', with: 'Six'
        fill_in 'Percent discount', with: 0.06
        fill_in 'Quantity threshold', with: 6
        click_button 'Create Bulk discount'

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

        six = BulkDiscount.last

        within('#bulk_discount-3') do
          expect(page).to have_content(six.name)
          expect(page).to have_content(six.display_discount)
          expect(page).to have_content(six.quantity_threshold)
        end
      end
    end

    describe '#new form will not accept incomplete forms' do
      it 'will generate a flash error message and redirect the user back to the #new form' do
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_link('Add new Discount')
        click_link('Add new Discount')

        fill_in 'Percent discount', with: 0.06

        click_button 'Create Bulk discount'

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
        expect(page).to have_content("Name can't be blank, Quantity threshold can't be blank, Quantity threshold is not a number")
      end
    end
  end
end
