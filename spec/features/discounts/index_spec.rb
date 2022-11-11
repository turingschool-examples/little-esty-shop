require "rails_helper"


RSpec.describe("Discounts Index Page") do
  before(:each) do
    @merchant = create(:merchant)
    @discount = create(:discount, merchant: @merchant)
    visit(merchant_discounts_path(@merchant))
  end
  describe 'When I visit /merchants/:merchant_id/discounts' do
    describe 'Then I see' do
      it 'all of my bulk discounts with % discount and # threshold' do
        within "#discounts-list-#{@merchant.id}" do
          expect(page).to have_content(@discount.quantity_threshold)
          expect(page).to have_content(@discount.percentage_discount)
        end
      end

      it 'each discount is a link to its show page' do
        within "#discounts-list-#{@merchant.id}" do
          click_link("#{@discount.id}")

          expect(current_path).to eq(merchant_discount_path(@merchant.id, @discount.id))
        end
      end

      it 'a link to create a "New Discount"' do

      end

      describe 'When I click "New Discount"'
      it 'I am taken to a discounts new page'
    end
  end
end
