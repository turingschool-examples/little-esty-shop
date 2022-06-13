require 'rails_helper'
RSpec.describe 'Merchant #destroy bulk discount' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
    @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                    merchant_id: @merchant1.id)
    @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                  merchant_id: @merchant1.id)
  end

  describe 'Merchant Create Bulk Discount page' do
    describe 'bulk discount index page has link to delete an exxisting bulk discount' do
      it 'can delete an existing bulk discount ' do
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_content("#{@merchant1.name}'s bulk discounts")

        within('#bulk_discount-0') do
          expect(page).to have_link(@ten.name)
          expect(page).to have_content(@ten.display_discount)
          expect(page).to have_content(@ten.quantity_threshold)
          expect(page).to have_link("Delete #{@ten.name} discount")

          click_link('Delete')
        end

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

        expect(page).to have_content('Your discount was deleted')
        expect(page).not_to have_content(@ten.name)
        expect(page).not_to have_content(@ten.display_discount)
        expect(page).not_to have_content(@ten.quantity_threshold)
      end
    end
  end
end
