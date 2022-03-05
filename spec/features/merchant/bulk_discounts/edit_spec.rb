require 'rails_helper'
RSpec.describe 'Merchant #edit bulk discount' do

  before :each do
    @merchant1 = Merchant.create!(name: "Suzy Hernandez")
    @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15, merchant_id: @merchant1.id)
    @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50, merchant_id: @merchant1.id)
  end

  describe "Merchant Edit Bulk Discount page" do

    describe 'bulk discount show page has link to edit a discount' do
      it '#edit' do

        visit merchant_bulk_discount_path(@merchant1.id, @ten.id)

        expect(page).to have_content(@ten.name)
        expect(page).to have_content(@ten.display_discount)
        expect(page).to have_content(@ten.quantity_threshold)
        expect(page).to have_link('Edit Bulk discount')

        click_link('Edit Bulk discount')

        fill_in 'Quantity threshold', with: 11

        click_button "Update Bulk discount"

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @ten.id))

        expect(page).to have_content(@ten.name)
        expect(page).to have_content(@ten.display_discount)
        expect(page).to have_content(@ten.quantity_threshold)
        expect(page).to have_content('With purchase of 11 or more')
        expect(page).to_not have_content('With purchase of 10 or more')
      end
    end
  end
end
