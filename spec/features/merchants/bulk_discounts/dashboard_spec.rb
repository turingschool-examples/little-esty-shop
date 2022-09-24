require 'rails_helper'

RSpec.describe 'Merchant Dashboard - Bulk Discounts' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 20)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_1, discount: 0.10, threshold: 15)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant_1, discount: 0.05, threshold: 10)

    @bulk_discount_4 = create(:bulk_discount, merchant: @merchant_2, discount: 0.45, threshold: 30)
    @bulk_discount_5 = create(:bulk_discount, merchant: @merchant_2, discount: 0.30, threshold: 20)
    @bulk_discount_6 = create(:bulk_discount, merchant: @merchant_2, discount: 0.20, threshold: 10)
  end

  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page

  describe 'User Story 1 - When I visit my merchant dashboard' do 
    it 'Then I see a link to view all my discounts' do
      visit  merchant_dashboard_path(@merchant_1)
      
      find_link({text: "Bulk Discount Index", href: merchant_bulk_discounts_path(@merchant_1)}).visible?

      visit  merchant_dashboard_path(@merchant_2)

      find_link({text: "Bulk Discount Index", href: merchant_bulk_discounts_path(@merchant_2)}).visible?
    end

    it 'When I click this link Then I am taken to my bulk discounts index page' do
      visit  merchant_dashboard_path(@merchant_1)

      click_on "Bulk Discount Index"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))

      visit  merchant_dashboard_path(@merchant_2)

      click_on "Bulk Discount Index"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_2))
    end

    it 'Where I see all of my bulk discounts including their percentage discount and quantity thresholds' do
      visit merchant_bulk_discounts_path(@merchant_1)
      
      within "#bulk-discount-#{@bulk_discount_1.id}" do
        expect(page).to have_content(@bulk_discount_1.discount)
        expect(page).to have_content(@bulk_discount_1.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_2.id}" do
        expect(page).to have_content(@bulk_discount_2.discount)
        expect(page).to have_content(@bulk_discount_2.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_3.id}" do
        expect(page).to have_content(@bulk_discount_3.discount)
        expect(page).to have_content(@bulk_discount_3.threshold)
      end

      visit merchant_bulk_discounts_path(@merchant_2)

      within "#bulk-discount-#{@bulk_discount_4.id}" do
        expect(page).to have_content(@bulk_discount_4.discount)
        expect(page).to have_content(@bulk_discount_4.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_5.id}" do
        expect(page).to have_content(@bulk_discount_5.discount)
        expect(page).to have_content(@bulk_discount_5.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_6.id}" do
        expect(page).to have_content(@bulk_discount_6.discount)
        expect(page).to have_content(@bulk_discount_6.threshold)
      end
    end

    it 'And each bulk discount listed includes a link to its show page' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within "#bulk-discount-#{@bulk_discount_1.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_1.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_2.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_2.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_2)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_3.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_3.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_3)}).visible?
      end

      visit merchant_bulk_discounts_path(@merchant_2)
      save_and_open_page
      within "#bulk-discount-#{@bulk_discount_4.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_4.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_5.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_5.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_5)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_6.id}" do
        find_link({text: "Show Page for Bulk Discount ID #{@bulk_discount_6.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_6)}).visible?
      end
    end
  end
end