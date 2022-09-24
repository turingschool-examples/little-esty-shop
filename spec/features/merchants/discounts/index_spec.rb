require 'rails_helper'

RSpec.describe 'Merchant Discounts Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @discounts = create_list(:discount, 5, merchant: @pretty_plumbing)
    @discounts_1 = create_list(:discount, 5, merchant: @merchant_1)

  end
  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page
  describe 'user story 1 solo' do
    it 'I see a link to view all my discounts' do
      visit merchant_dashboard_path(@merchant_1)

      find_link({text: "Discounts Index", href: merchant_discounts_path(@merchant_1)}).visible?
    end

    it 'I click this link and I am taken to my bulk discounts index page' do
      visit merchant_dashboard_path(@pretty_plumbing)

      click_on "Discounts Index"
      expect(current_path).to eq(merchant_discounts_path(@pretty_plumbing))
    end

    it 'I see all of my bulk discounts with percentage discount and quantity thresholds' do
      visit merchant_discounts_path(@pretty_plumbing)

      within("#discount-#{@discounts[0].id}") do
        expect(page).to have_content(@discounts[0].bulk_discount.round(2))
        expect(page).to have_content(@discounts[0].item_threshold)
        expect(page).to_not have_content(@discounts[1].id)
        expect(page).to_not have_content(@discounts[2].id)
      end
      within("#discount-#{@discounts[1].id}") do
        expect(page).to have_content(@discounts[1].bulk_discount.round(2))
        expect(page).to have_content(@discounts[1].item_threshold)
        expect(page).to_not have_content(@discounts[0].id)
        expect(page).to_not have_content(@discounts[4].id)
      end
    end

    it 'And each bulk discount listed includes a link to its show page' do
      visit merchant_discounts_path(@pretty_plumbing)

      within("#discount-#{@discounts[0].id}") do
        find_link({text: "Discount #{@discounts[0].id}", href: merchant_discount_path(@pretty_plumbing, @discounts[0].id)}).visible?
        click_on "Discount #{@discounts[0].id}"
        expect(current_path).to eq(merchant_discount_path(@pretty_plumbing, @discounts[0].id))
      end
    end
  end
#   As a merchant
# When I visit my bulk discounts index
# Then next to each bulk discount I see a link to delete it
# When I click this link
# Then I am redirected back to the bulk discounts index page
# And I no longer see the discount listed
  describe 'user story 3-solo' do
    it 'I see a link to delete discount and click it and I no longer see the discount' do
      visit merchant_discounts_path(@merchant_1)

      within("#discount-#{@discounts_1[1].id}") do
        expect(page).to have_content(@discounts_1[1].bulk_discount.round(2))
        expect(page).to have_content(@discounts_1[1].item_threshold)
      end
      click_button "Delete #{@discounts_1[1].id}"
      expect(current_path).to eq(merchant_discounts_path(@merchant_1))

      expect(page).to_not have_content(@discounts_1[1].id)

      visit merchant_discounts_path(@pretty_plumbing)

      within("#discount-#{@discounts[2].id}") do
        expect(page).to have_content(@discounts[2].bulk_discount.round(2))
        expect(page).to have_content(@discounts[2].item_threshold)
      end
      click_button "Delete #{@discounts[2].id}"
      expect(current_path).to eq(merchant_discounts_path(@pretty_plumbing))

      expect(page).to_not have_content(@discounts[2].id)
    end
  end
end
