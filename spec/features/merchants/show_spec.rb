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
  let!(:invoice_item1) { create(:invoice_item, item: @items[0], invoice: @invoices[0]) }
  let!(:invoice_item2) { create(:invoice_item, item: @items[1], invoice: @invoices[1]) }
  let!(:invoice_item3) { create(:invoice_item, item: @items[0], invoice: @invoices[2]) }
  let!(:invoice_item4) { create(:invoice_item, item: @items[1], invoice: @invoices[3]) }
  let!(:invoice_item5) { create(:invoice_item, item: @items[0], invoice: @invoices[4]) }
  let!(:invoice_item6) { create(:invoice_item, item: @items[1], invoice: @invoices[5]) }
  let!(:invoice_item7) { create(:invoice_item, item: @items[0], invoice: @invoices[6]) }
  let!(:invoice_item8) { create(:invoice_item, item: @items[1], invoice: @invoices[7]) }
  let!(:invoice_item9) { create(:invoice_item, item: @items[0], invoice: @invoices[8]) }
  let!(:invoice_item10) { create(:invoice_item, item: @items[1], invoice: @invoices[9]) }
  let!(:invoice_item11) { create(:invoice_item, item: @items[0], invoice: @invoices[10]) }
  let!(:invoice_item12) { create(:invoice_item, item: @items[1], invoice: @invoices[11]) }

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

      expect(page).to have_content("1. #{customers[1].first_name} #{customers[1].last_name} - 8 purchases")
      expect(page).to have_content("2. #{customers[2].first_name} #{customers[2].last_name} - 8 purchases")
      expect(page).to have_content("3. #{customers[3].first_name} #{customers[3].last_name} - 8 purchases")
      expect(page).to have_content("4. #{customers[4].first_name} #{customers[4].last_name} - 8 purchases")
      expect(page).to have_content("5. #{customers[5].first_name} #{customers[5].last_name} - 8 purchases")

    end
  end
end
