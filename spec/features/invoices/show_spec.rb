require 'rails_helper'

RSpec.describe 'merchants invoices index page', type: :feature do
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

    it 'can show all that merchants invoice attributes' do
      visit merchant_invoice_path(@merchant.id, @invoice_9.id)

      expect(page).to have_content(@invoice_9.id)
      expect(page).to have_content(@invoice_9.status)
      expect(page).to have_content(@invoice_9.date)
    end

    it 'can show customer info for invoice' do
      visit merchant_invoice_path(@merchant.id, @invoice_9.id)

      expect(page).to have_content("Customer: #{@invoice_9.customer_name}")
      expect(page).to have_content("Address: 123 Drury Ln")
      expect(page).to have_content("Nowhere, ID 10001")
    end

    it 'can show my items on the invoice' do
      visit merchant_invoice_path(@merchant.id, @invoice_9.id)
      invoice_item = @invoice_9.invoice_items.first
      expect(page).to have_content("#{invoice_item.item.name}")
      expect(page).to have_content("#{invoice_item.quantity}")
      expect(page).to have_content("#{invoice_item.unit_price}")
    end

    it 'can show total revenue for that invoice' do
      visit merchant_invoice_path(@merchant.id, @invoice_9.id)

      expect(page).to have_content("Total Revenue: #{@invoice_9.total_revenue}")
    end

    xit 'can enable/disable status of item' do
      visit merchant_invoice_path(@merchant.id, @invoice_9.id)
      save_and_open_page
      expect(page).to have_field('item[status]', with: "#{@invoice_9.items.first.status}")

      click_on 'Submit'
      expect(page).to have_field('item[status]', with: "#{@invoice_9.items.first.status}")
    end

  end
end
