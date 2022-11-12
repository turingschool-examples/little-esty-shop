require "rails_helper"
require 'webmock/rspec'

RSpec.describe("Discounts Index Page") do
  before(:each) do
    @merchant = create(:merchant)
    @discount = create(:discount, merchant: @merchant, quantity_threshold: 30, percentage_discount: 30)

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
        within "#discounts-links-#{@merchant.id}" do
          expect(page).to have_link("New Discount")
        end
      end

      describe 'When I click "New Discount"' do
        it 'I am taken to a discounts new page' do
          within "#discounts-links-#{@merchant.id}" do
            click_link("New Discount")

            expect(current_path).to eq(new_merchant_discount_path(@merchant.id))
          end
        end
      end

      it 'a link to "Delete" a discount' do
        within "#discounts-list-#{@merchant.id}" do
          expect(page).to have_link("Delete")
        end
      end

      describe 'When I click on "Delete"' do
        it 'I am taken back to the Discounts Index Page and no longer see the deleted discount' do
          click_link("Delete")
          expect(current_path).to eq(merchant_discounts_path(@merchant))
          expect(page).to_not have_content(@discount.quantity_threshold)
          expect(page).to_not have_content(@discount.percentage_discount)
        end
      end

      describe 'A section for the next three public holidays for the US' do
        it 'displays the name and date for the next 3 "Upcoming Holidays"' do
          within "#next-holidays-#{@merchant.id}" do
            expect(page).to have_content("Test Day: 2022-11-11\nThanksgiving Day: 2022-11-24\nChristmas Day: 2022-12-26")
        end
        end
      end
    end
  end
end
