require 'rails_helper'

RSpec.describe 'Merchants show page', type: :feature do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

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
  let!(:invoice_item12) { create(:invoice_item, item: @items[1], invoice: @invoices[11], status: 2) }

  describe 'Merchant Dashboard' do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it "has the merchant's name" do
      visit "/merchants/#{merchant1.id}/dashboard"

      # save_and_open_page # does not include CSS

      expect(page).to have_content(merchant1.name)
    end
  end

  describe 'Dashboard Links' do
    it 'links to merchant items and merchant invoices' do
      visit "/merchants/#{merchant1.id}/dashboard"
      click_link 'My Items'
      expect(current_path).to eq("/merchants/#{merchant1.id}/items")

      visit "/merchants/#{merchant1.id}/dashboard"

      click_link 'My Invoices'
      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
    end

    it "can display top 5 customers and their transaction count" do

      visit "/merchants/#{merchants[0].id}/dashboard"
      tied_customers = [customers[1], customers[2], customers[3], customers[4], customers[5]]
      expected = tied_customers.sort_by(&:last_name).sort_by(&:first_name)

      expect(page).to have_content("1. #{expected[0].first_name} #{expected[0].last_name} - 8 purchases")
      expect(page).to have_content("2. #{expected[1].first_name} #{expected[1].last_name} - 8 purchases")
      expect(page).to have_content("3. #{expected[2].first_name} #{expected[2].last_name} - 8 purchases")
      expect(page).to have_content("4. #{expected[3].first_name} #{expected[3].last_name} - 8 purchases")
      expect(page).to have_content("5. #{expected[4].first_name} #{expected[4].last_name} - 8 purchases")

    end
  end

  describe 'merchant dashboard items ready to ship' do
    it 'has a section for items ready to ship' do
      visit "/merchants/#{merchants[0].id}/dashboard"

      expect(page).to have_content("Items Ready to Ship")
      within ".invoice-item-#{invoice_item1.id}" do
        expect(page).to have_content("#{@items[0].name} - Invoice ##{invoice_item1.invoice_id}")
        click_link "Invoice ##{invoice_item1.invoice_id}"
      end
      expect(current_path).to eq("/merchants/#{merchants[0].id}/invoices/#{invoice_item1.invoice_id}")
    end
  end

  describe 'merchant dashboard invoices sorted by least recent' do
    it 'has a the invoices sorted by least recent' do
      visit "/merchants/#{merchants[0].id}/dashboard"

      within "#leftSide2" do

        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_link("Invoice ##{invoice_item1.invoice_id}")
        expect(page).to have_content("#{@items[0].name} - Invoice ##{invoice_item1.invoice_id} - #{invoice_item1.invoice.created_at.strftime("%A, %B %d, %Y")}")
        # This .strftime("%A, %B %d, %Y") will format date to look like "Monday, July 18, 2019"

        expect("Invoice ##{invoice_item1.invoice_id}").to appear_before("Invoice ##{invoice_item2.invoice_id}")
        expect("Invoice ##{invoice_item2.invoice_id}").to appear_before("Invoice ##{invoice_item3.invoice_id}")
        expect("Invoice ##{invoice_item3.invoice_id}").to appear_before("Invoice ##{invoice_item4.invoice_id}")
        # need to refactor "invoice_item1.invoice.created_at" into it's own method
        # also item.name
      end
    end
  end
end
