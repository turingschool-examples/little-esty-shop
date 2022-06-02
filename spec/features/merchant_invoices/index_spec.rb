require 'rails_helper'

# As a merchant,
# When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page
RSpec.describe "Index page", type: :feature do

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


  describe 'Merchant invoices user story 1' do
    it "can see all merchants invoices with items and a link to the invoice show page" do

      visit "/merchants/#{merchants[0].id}/invoices"

      expect(page).to have_content("Invoice ##{@invoices[0].id}")
      expect(page).to have_content("Invoice ##{@invoices[1].id}")
      expect(page).to have_content("Invoice ##{@invoices[2].id}")
      expect(page).to have_content("Invoice ##{@invoices[3].id}")
      expect(page).to have_content("Invoice ##{@invoices[4].id}")
      expect(page).to have_content("Invoice ##{@invoices[5].id}")
      expect(page).to_not have_content("Invoice ##{@invoices[11].id}")

      click_link "Invoice ##{@invoices[0].id}"

      expect(current_path).to eq("/merchants/#{merchants[0].id}/invoices/#{@invoices[0].id}")
    end
  end
end
