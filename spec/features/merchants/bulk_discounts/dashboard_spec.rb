require 'rails_helper'

RSpec.describe 'Merchant Dashboard - Bulk Discounts' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant_1, discount: 0.25, threshold: 20)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant_1, discount: 0.10, threshold: 15)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant_1, discount: 0.05, threshold: 12)

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
        expect(page).to_not have_content(@bulk_discount_4.discount)
        expect(page).to_not have_content(@bulk_discount_4.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_2.id}" do
        expect(page).to have_content(@bulk_discount_2.discount)
        expect(page).to have_content(@bulk_discount_2.threshold)
        expect(page).to_not have_content(@bulk_discount_5.discount)
        expect(page).to_not have_content(@bulk_discount_5.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_3.id}" do
        expect(page).to have_content(@bulk_discount_3.discount)
        expect(page).to have_content(@bulk_discount_3.threshold)
        expect(page).to_not have_content(@bulk_discount_4.discount)
        expect(page).to_not have_content(@bulk_discount_4.threshold)
      end

      visit merchant_bulk_discounts_path(@merchant_2)

      within "#bulk-discount-#{@bulk_discount_4.id}" do
        expect(page).to have_content(@bulk_discount_4.discount)
        expect(page).to have_content(@bulk_discount_4.threshold)
        expect(page).to_not have_content(@bulk_discount_3.discount)
        expect(page).to_not have_content(@bulk_discount_3.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_5.id}" do
        expect(page).to have_content(@bulk_discount_5.discount)
        expect(page).to have_content(@bulk_discount_5.threshold)
        expect(page).to_not have_content(@bulk_discount_2.discount)
        expect(page).to_not have_content(@bulk_discount_2.threshold)
      end

      within "#bulk-discount-#{@bulk_discount_6.id}" do
        expect(page).to have_content(@bulk_discount_6.discount)
        expect(page).to have_content(@bulk_discount_6.threshold)
        expect(page).to_not have_content(@bulk_discount_1.discount)
        expect(page).to_not have_content(@bulk_discount_1.threshold)
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

  # As a merchant
  # When I visit my bulk discounts index
  # Then I see a link to create a new discount
  # When I click this link
  # Then I am taken to a new page where I see a form to add a new bulk discount
  # When I fill in the form with valid data
  # Then I am redirected back to the bulk discount index
  # And I see my new bulk discount listed
  
  describe 'User Story 2 - When I visit my bulk discounts index' do 
    it ' Then I see a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within "#link-create-bulk-discount" do
        find_link({text: "Create New Bulk Discount for #{@merchant_1.name}", href: new_merchant_bulk_discount_path(@merchant_1)}).visible?
      end

      visit merchant_bulk_discounts_path(@merchant_2)

      within "#link-create-bulk-discount" do
        find_link({text: "Create New Bulk Discount for #{@merchant_2.name}", href: new_merchant_bulk_discount_path(@merchant_2)}).visible?
      end
    end

    it 'When I click this link Then I am taken to a new page where I see a form to add a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant_1)

      click_on "Create New Bulk Discount for #{@merchant_1.name}"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))

      visit merchant_bulk_discounts_path(@merchant_2)

      click_on "Create New Bulk Discount for #{@merchant_2.name}"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_2))
    end

    it 'When I fill in the form with valid data Then I am redirected back to the bulk discount index and I see new bulk discount' do
      visit new_merchant_bulk_discount_path(@merchant_1)
      
      within "#create-bulk-discount" do
        fill_in 'bulk_discount[discount]', with: 0.5
        fill_in 'bulk_discount[threshold]', with: 30
        click_on "Create New Discount"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))

      expect(page).to have_content("Discount: 0.5")
      expect(page).to have_content("Threshold: 30")

      visit new_merchant_bulk_discount_path(@merchant_2)

      within "#create-bulk-discount" do
        fill_in 'bulk_discount[discount]', with: 0.15
        fill_in 'bulk_discount[threshold]', with: 100
        click_on "Create New Discount"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_2))

      expect(page).to have_content("Discount: 0.15")
      expect(page).to have_content("Threshold: 100")
    end
  end

  # As a merchant
  # When I visit my bulk discounts index
  # Then next to each bulk discount I see a link to delete it
  # When I click this link
  # Then I am redirected back to the bulk discounts index page
  # And I no longer see the discount listed

  describe 'User Story 3 - When I visit my bulk discounts index' do
    it 'Then next to each bulk discount I see a link to delete it' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within "#bulk-discount-#{@bulk_discount_1.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_1.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_2.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_2.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_2)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_3.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_3.id}", href: merchant_bulk_discount_path(@merchant_1, @bulk_discount_3)}).visible?
      end

      visit merchant_bulk_discounts_path(@merchant_2)

      within "#bulk-discount-#{@bulk_discount_4.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_4.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_4)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_5.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_5.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_5)}).visible?
      end

      within "#bulk-discount-#{@bulk_discount_6.id}" do
        find_link({text: "Delete Bulk Discount ID #{@bulk_discount_6.id}", href: merchant_bulk_discount_path(@merchant_2, @bulk_discount_6)}).visible?
      end
    end

    it 'When I click this link Then I am redirected to the bulk discounts index pageAnd I no longer see the discount listed' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within "#bulk-discount-#{@bulk_discount_1.id}" do
        click_on "Delete Bulk Discount ID #{@bulk_discount_1.id}"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))

      expect(page).to_not have_content(@bulk_discount_1.discount)
      expect(page).to_not have_content(@bulk_discount_1.threshold)
  
      visit merchant_bulk_discounts_path(@merchant_2)

      within "#bulk-discount-#{@bulk_discount_4.id}" do
        click_on "Delete Bulk Discount ID #{@bulk_discount_4.id}"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_2))

      expect(page).to_not have_content(@bulk_discount_4.discount)
      expect(page).to_not have_content(@bulk_discount_4.threshold)
    end
  end
end