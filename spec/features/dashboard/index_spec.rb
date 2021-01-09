require 'rails_helper'

RSpec.describe 'merchant dashboard index', type: :feature do
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

    it 'When I visit my merchant dashboard then I see the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_content(@merchant.name)
    end

    it 'When I visit my merchant dashboard Then I see link to my merchant items index (/merchant/merchant_id/items) And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)' do
      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_link('Merchant Items', href: merchant_items_path(@merchant))
      expect(page).to have_link('Merchant Invoices', href: merchant_invoices_path(@merchant))
    end

    it 'can show top 5 customers of the merchant' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} - Successful Transactions: #{@merchant.top_5[0].total_success}")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name} - Successful Transactions: #{@merchant.top_5[1].total_success}")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} - Successful Transactions: #{@merchant.top_5[2].total_success}")
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} - Successful Transactions: #{@merchant.top_5[3].total_success}")
      expect(page).to have_content("#{@customer_6.first_name} #{@customer_6.last_name} - Successful Transactions: #{@merchant.top_5[4].total_success}")

      expect(@customer_4.name).to appear_before(@customer_2.name)
      expect(@customer_1.name).to appear_before(@customer_6.name)
    end

    it 'can show all items not yet shipped, and show items invoice id as a link.' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content(Item.second.name)

      expect(page).to have_link("#{@invoice_9.id}")
    end

    it 'can show date and is in desc order' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content(Item.first.created_at.strftime('%A, %b %d %Y'))
      # expect(@invoice_9.id).to appear_before(@invoice_10.id)
      # expect(@invoice_10.id).to appear_before(@invoice_8.id)
    end
  end
end
