require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
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

  describe 'merchant items' do
    it 'has list of items for a specific merchant' do
      visit "/merchants/#{merchants[0].id}/items"
      # save_and_open_page
      expect(page).to have_content(@items[0].name)
      expect(page).to have_content(@items[1].name)
      expect(page).to_not have_content(@items[2].name)
      expect(page).to_not have_content(@items[3].name)
    end
  end

  describe 'merchant items links on index page' do 
    it 'has links for the item names' do 
      visit "/merchants/#{merchants[0].id}/items"

      within ".merchant-items-#{merchants[0].items[0].id}" do 
        click_link "#{merchants[0].items[0].name}"
      end
      expect(current_path). to eq("/merchants/#{merchants[0].id}/items/#{@items[0].id}")

      visit "/merchants/#{merchants[0].id}/items"

      within ".merchant-items-#{merchants[0].items[1].id}" do 
        click_link "#{merchants[0].items[1].name}"
      end 
      expect(current_path). to eq("/merchants/#{merchants[0].id}/items/#{@items[1].id}")
    end 
  end

  describe 'merchant item disable/enable' do 
    it 'has a button to disable or enable item' do 
      visit "/merchants/#{merchants[0].id}/items"

      within ".merchant-items-#{merchants[0].items[1].id}" do 
        expect(page).to have_content("")
      end
    end
  end
end
