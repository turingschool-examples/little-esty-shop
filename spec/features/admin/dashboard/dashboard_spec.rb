require 'rails_helper'

describe 'As an Admin' do
  describe 'When i visit the admin dashboard' do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      
      Customer.all.each do |customer|
        create_list(:invoice, 1, customer: customer, merchant: @merchant)
      end

      customer_list = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5, @customer_6]

      customer_list.size.times do |i|
        create_list(:transaction, (i+1), invoice: customer_list[i].invoices.first, result: 1)
      end
    end

    it 'I the admins dashboard with nav links' do
      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
      expect(page).to have_link("Admin Merchants")
      expect(page).to have_link("Admin Invoices")
    end

    it 'I can see the top customers' do
      visit admin_index_path

      
      within('#top-customers') do
        expect(page).to have_content("Top 5 Customers")
        expect(all('.customer')[0].text).to eq("#{@customer_6.name} - #{@customer_6.successful_purchases} Purchases")
        expect(all('.customer')[1].text).to eq("#{@customer_5.name} - #{@customer_5.successful_purchases} Purchases")
        expect(all('.customer')[2].text).to eq("#{@customer_4.name} - #{@customer_4.successful_purchases} Purchases")
        expect(all('.customer')[3].text).to eq("#{@customer_3.name} - #{@customer_3.successful_purchases} Purchases")
        expect(all('.customer')[4].text).to eq("#{@customer_2.name} - #{@customer_2.successful_purchases} Purchases")
      end
    end

    it 'I see all incomplete invoices sorted by least recent' do
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2006-01-25 09:54:09")
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 1, created_at: "2007-02-25 09:54:09")
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2008-03-25 09:54:09")
      @invoice_4 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2009-04-25 09:54:09")

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)

      @invoice_item_1 = create(:invoice_item, status: 0, item: @item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, status: 0, item: @item_2, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, status: 1, item: @item_2, invoice: @invoice_3)
      @invoice_item_4 = create(:invoice_item, status: 1, item: @item_1, invoice: @invoice_4)

      visit admin_index_path

      within("#incomplete-invoices") do
        expect(page).to have_content("Incomplete Invoices")
        
        expect(all('.invoice')[0].text).to eq("#{@invoice_1.id} - #{@invoice_1.date}") 
        expect(all('.invoice')[1].text).to eq("#{@invoice_2.id} - #{@invoice_2.date}")  
        expect(all('.invoice')[2].text).to eq("#{@invoice_3.id} - #{@invoice_3.date}")   
        expect(all('.invoice')[3].text).to eq("#{@invoice_4.id} - #{@invoice_4.date}")  
        
        expect(page).to have_link("#{@invoice_1.id} - #{@invoice_1.date}")
        expect(page).to have_link("#{@invoice_2.id} - #{@invoice_2.date}")
        expect(page).to have_link("#{@invoice_3.id} - #{@invoice_3.date}")
        expect(page).to have_link("#{@invoice_4.id} - #{@invoice_4.date}")
      end
    end
  end
end