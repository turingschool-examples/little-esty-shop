require 'rails_helper'
RSpec.describe 'The Merchant Invoices Index' do

  before :each do
    @merchant1 = Merchant.create!(name: "Suzy Hernandez")
  end

  describe "Merchant Bulk Discount index page page" do
    it "will list a merchant's bulk discounts, including their percentage discount and quantity thresholds" do

    visit merchant_dashboard_index_path (@merchant1)

    expect(current_path).to eq(merchant_bulk_discount_index_path(@merchant1))

    within("#bulk_discount-0") do
      expect(page).to have_content(@ten.name)
      expect(page).to have_content(@ten.percent_discount)
      expect(page).to have_content(@ten.quantity_thresholds)
    end

    within("#bulk_discount-1") do
      expect(page).to have_content(@fifteen.name)
      expect(page).to have_content(@fifteen.percent_discount)
      expect(page).to have_content(@fifteen.quantity_thresholds)
    end

    within("#bulk_discount-2") do
      expect(page).to have_content(@fifty.name)
      expect(page).to have_content(@fifty.percent_discount)
      expect(page).to have_content(@fifty.quantity_thresholds)
    end
    end
  end 
end
