require 'rails_helper'

RSpec.describe 'Merchant_Invoices Show Page', type: :feature do
  let!(:merchants) { create_list(:merchant, 2) }
  let!(:customers) { create_list(:customer, 6) }

  before :each do
    @items = merchants.flat_map do |merchant|
      create_list(:item, 2, merchant: merchant)
    end

    @invoices = customers.flat_map do |customer|
      create_list(:invoice, 2, customer: customer)
    end

    @transactions = @invoices.each_with_index.flat_map do |invoice, index|
      if index < 2
        create_list(:transaction, 2, invoice: invoice, result: 1)
      else
        create_list(:transaction, 2, invoice: invoice, result: 0)
      end
    end

  end
  let!(:invoice_item1) { create(:invoice_item, item: @items[0], invoice: @invoices[0], status: 0) }
  let!(:invoice_item2) { create(:invoice_item, item: @items[1], invoice: @invoices[1], status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: @items[0], invoice: @invoices[2], status: 1) }
  let!(:invoice_item4) { create(:invoice_item, item: @items[1], invoice: @invoices[3], status: 0) }
  let!(:invoice_item5) { create(:invoice_item, item: @items[0], invoice: @invoices[4], status: 0) }
  let!(:invoice_item6) { create(:invoice_item, item: @items[1], invoice: @invoices[5], status: 1) }
  let!(:invoice_item7) { create(:invoice_item, item: @items[0], invoice: @invoices[6], status: 1) }
  let!(:invoice_item8) { create(:invoice_item, item: @items[1], invoice: @invoices[7], status: 1) }
  let!(:invoice_item9) { create(:invoice_item, item: @items[0], invoice: @invoices[8], status: 1) }
  let!(:invoice_item10) { create(:invoice_item, item: @items[1], invoice: @invoices[9], status: 0) }
  let!(:invoice_item11) { create(:invoice_item, item: @items[0], invoice: @invoices[10], status: 2) }
  let!(:invoice_item12) { create(:invoice_item, item: @items[2], invoice: @invoices[11], status: 1) }
  let!(:invoice_item13) { create(:invoice_item, item: @items[2], invoice: @invoices[0], status: 1) }

# Merchant Invoice Show Page
#
# As a merchant
# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"
# - Customer first and last name
  describe 'Merchant_Invoices User Story 2' do
    it "can display all information related to an invoice" do
      visit "/merchants/#{merchants[0].id}/invoices/#{@invoices[0].id}"

      expect(page).to have_content("Invoice: #{@invoices[0].id}")
      expect(page).to have_content("Status: #{@invoices[0].status}")
      expect(page).to_not have_content("Status: #{@invoices[11].status}")
      expect(page).to have_content("Created on: #{@invoices[0].created_at.strftime("%A, %B %d, %Y")}")

      expect(page).to have_content("#{customers[0].first_name} #{customers[0].last_name}")
      expect(page).to_not have_content("#{customers[1].first_name} #{customers[1].last_name}")
    end
  end
end
