require 'rails_helper'

RSpec.describe 'new merchant bulk discount page' do
  let!(:merchant_1) { Merchant.create!(name: Faker::Name.unique.name) }

  let!(:disc_10m1) { 
    merchant_1.bulk_discounts.create!(
      discount_percent: 10,
      quantity_threshold: 5
    )
  }
  let!(:disc_15m1) { 
    merchant_1.bulk_discounts.create!(
      discount_percent: 15,
      quantity_threshold: 8
    )
  }
  
  before :each do
    visit new_merchant_bulk_discount_path(merchant_1)
  end

  describe 'when I visit the page' do
    it 'has a form to add a new bulk discount' do
      expect(page).to have_field(:bulk_discount_discount_percent)
      expect(page).to have_field(:bulk_discount_quantity_threshold)
      expect(page).to have_button("Add new discount")
    end

    describe 'when I fill out the form with valid data and click submit' do
      let!(:new_disc_percent) { Faker::Number.number(digits: 2)}
      let!(:new_qty_threshold) { Faker::Number.number(digits: 2)}

      before :each do
        fill_in :bulk_discount_discount_percent, with: new_disc_percent
        fill_in :bulk_discount_quantity_threshold, with: new_qty_threshold
        click_on "Add new discount"
      end

      it 'creates a new bulk discount for that merchant' do
        new_discount = BulkDiscount.last
        expect(new_discount.discount_percent).to eq(new_disc_percent)
        expect(new_discount.quantity_threshold).to eq(new_qty_threshold)
      end

      describe 'takes me back to the merchant bulk discount index page' do
        it 'where I see the new discount displayed along with any others' do
          new_discount = BulkDiscount.last

          within "#discount-#{disc_10m1.id}" do
            expect(page).to have_content("#{disc_10m1.discount_percent}% off #{disc_10m1.quantity_threshold} or more items!")
          end
      
          within "#discount-#{disc_15m1.id}" do
            expect(page).to have_content("#{disc_15m1.discount_percent}% off #{disc_15m1.quantity_threshold} or more items!")
          end
      
          within "#discount-#{new_discount.id}" do
            expect(page).to have_content("#{new_discount.discount_percent}% off #{new_discount.quantity_threshold} or more items!")
          end
        end
      end
    end
  end
end