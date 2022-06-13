require 'rails_helper'
RSpec.describe 'The Merchant Bulk Discount Index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
    @ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                    merchant_id: @merchant1.id)
    @fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                  merchant_id: @merchant1.id)
    @holidays = HolidayFacade.find_holiday[0..2]
  end

  describe 'Merchant Bulk Discount index page page' do
    it "will list a merchant's bulk discounts, including their percentage discount and quantity thresholds" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_link("#{@merchant1.name}'s bulk discount index")
      click_link("#{@merchant1.name}'s bulk discount index")
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

      expect(page).to have_content("#{@merchant1.name}'s bulk discounts")

      within('#bulk_discount-0') do
        expect(page).to have_link(@ten.name)
        expect(page).to have_content(@ten.display_discount)
        expect(page).to have_content(@ten.quantity_threshold)
      end

      within('#bulk_discount-1') do
        expect(page).to have_link(@fifteen.name)
        expect(page).to have_content(@fifteen.display_discount)
        expect(page).to have_content(@fifteen.quantity_threshold)
      end

      within('#bulk_discount-2') do
        expect(page).to have_link(@fifty.name)
        expect(page).to have_content(@fifty.display_discount)
        expect(page).to have_content(@fifty.quantity_threshold)
      end
    end
  end
  describe 'it will list the upcomming holidays' do
    it '' do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_content('Upcomming Holidays')

      expect(page).to have_content(@holidays[0].name)
      expect(page).to have_content(@holidays[1].name)
      expect(page).to have_content(@holidays[2].name)
    end
  end
end
