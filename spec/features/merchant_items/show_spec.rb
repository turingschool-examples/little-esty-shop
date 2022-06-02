require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
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

  describe 'basic attributes on show page' do 
    it 'shows name, description, and current selling price for an item' do 
      visit "/merchants/#{merchants[0].id}/items/#{@items[1].id}"

      expect(page).to have_content(@items[1].name)
      expect(page).to have_content("Description: #{@items[1].description}")
      expect(page).to have_content("Current Price: #{@items[1].unit_price}")
      expect(page).to_not have_content(@items[0].name)

      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}"

      expect(page).to have_content(@items[0].name)
      expect(page).to have_content("Description: #{@items[0].description}")
      expect(page).to have_content("Current Price: #{@items[0].unit_price}")
      expect(page).to_not have_content(@items[1].name)
    end
  end

  describe 'merchant item update' do 
    it 'has a link to update the item information' do 
      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}"

      click_link "Update Item"
      expect(current_path).to eq("/merchants/#{merchants[0].id}/items/#{@items[0].id}/edit")
    end
  end
end 