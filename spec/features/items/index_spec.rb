require 'rails_helper'

RSpec.describe 'merchants items index page', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      Merchant.destroy_all
      Customer.destroy_all
      Transaction.destroy_all
      Invoice.destroy_all
      @merchant = create(:merchant)
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
      @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
      create(:transaction, result: 1, invoice: @invoice_1)
      create(:transaction, result: 1, invoice: @invoice_2)

      @customer_2 = create(:customer)
      @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
      @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_4)

      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_5)
      @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_5)
      create(:transaction, result: 1, invoice: @invoice_5)
      create(:transaction, result: 1, invoice: @invoice_5)
      create(:transaction, result: 1, invoice: @invoice_6)

      @customer_4 = create(:customer)
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)

      @customer_3 = create(:customer)
      @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_3)
      create(:transaction, result: 0, invoice: @invoice_7)

      @customer_6 = create(:customer)
      @invoice_9 = create(:invoice, merchant: @merchant, customer: @customer_6, created_at: '2010-03-27 14:53:59')
      @invoice_10 = create(:invoice, merchant: @merchant, customer: @customer_6, created_at: '2010-01-27 14:53:59')
      create(:transaction, result: 1, invoice: @invoice_9)

      create_list(:item, 3, merchant: @merchant)

      5.times do
        create(:invoice_item, item: Item.first, invoice: Invoice.all.sample, status: 2)
      end

      2.times do
        create(:invoice_item, item: Item.second, invoice: @invoice_9, status: 1)
      end
      3.times do
        create(:invoice_item, item: Item.second, invoice: @invoice_7, status: 1)
      end

      5.times do
        create(:invoice_item, item: Item.third, invoice: Invoice.all.sample, status: 0)
      end
    end

    it 'can list all item names for specific merchant' do
      visit merchant_items_path(@merchant)
      expected = Item.where(merchant: @merchant).pluck(:name)
      
      expect(page).to have_content("#{expected[0]}")
      expect(page).to have_content("#{expected[1]}")
      expect(page).to have_content("#{expected[2]}")
      expect(page).to have_link("#{expected[0]}")
    end

    it 'my page has sections for enabled and disabled items and each item has a button that changes its status' do
      item = Item.first

      visit merchant_items_path(@merchant)

      within('#items-disabled') do
        expect(page).to have_content(item.name)
        click_on(id: "btn-enable-#{item.id}")
        expect(current_path).to eq(merchant_items_path(@merchant))
      end

      within('#items-enabled') do
        expect(page).to have_content(item.name)
      end
    end

    it 'has a link to create new item and when a new item is created it is shown on the page' do
      visit merchant_items_path(@merchant)

      click_link('New Item')
      expect(current_path).to eq(new_merchant_item_path(@merchant))
      fill_in 'item_name', with: 'New Item'
      fill_in 'item_unit_price', with: 120
      fill_in 'item_description', with: 'This item is very new and special and cool'
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_content('New Item')
    end
  end
end
