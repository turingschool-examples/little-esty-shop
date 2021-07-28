require 'rails_helper'

RSpec.describe 'Admin Index' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice3 = create(:invoice, customer_id: @customer3.id)
    @invoice4 = create(:invoice, customer_id: @customer4.id)
    @invoice5 = create(:invoice, customer_id: @customer5.id)
    @invoice6 = create(:invoice, customer_id: @customer6.id)

    @merchant = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice2.id, status: 0)
    @invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice3.id, status: 1)
    @invoice_item4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice5.id, status: 2)
    @invoice_item6 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice6.id, status: 0)


    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @transaction2 = create(:transaction, invoice_id: @invoice1.id)
    @transaction3 = create(:transaction, invoice_id: @invoice2.id)
    @transaction4 = create(:transaction, invoice_id: @invoice3.id)
    @transaction5 = create(:transaction, invoice_id: @invoice4.id)
    @transaction6 = create(:transaction, invoice_id: @invoice5.id)
    @transaction7 = create(:transaction, invoice_id: @invoice6.id)

    Transaction.last(1).map { |t| t.update!(result: 1) }

    visit admin_index_path
  end

  describe 'Admin Dashboard' do
    it 'Visits the Admin Dash' do

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'Admin Dashboard links' do
    it 'has links to merchant/invoice index' do

      expect(page).to have_link('Admin Invoices')
      expect(page).to have_link('Admin Merchants')
    end
  end

  describe 'Admin Dashboard Statistics' do
    it 'displays the names of the top 5 customers and num of successful transcations' do
      
      within('#top_customers') do
        expect(page).to have_content('Top 5 Customers')
      end

      within("#customer-#{@customer1.id}") do
        expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}: 3")
      end

      within("#customer-#{@customer2.id}") do
        expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}: 2")
      end

      within("#customer-#{@customer3.id}") do
        expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}: 2")
      end

      within("#customer-#{@customer4.id}") do
        expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}: 2")
      end

      within("#customer-#{@customer5.id}") do
        expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}: 2")
      end
    end
  end

  describe 'Admin Dasboard Incomplete Invoices' do
    it 'displays a list of ids of invocies not shipped ' do

      within('#incomplete') do
        expect(page).to have_content('Incomplete Invoices')
      end
      
      within("#invoice-#{@invoice1.id}") do
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_link("#{@invoice1.id}")
      end

      within("#invoice-#{@invoice2.id}") do
        expect(page).to have_content(@invoice2.id)
        expect(page).to have_link("#{@invoice2.id}")
      end

      within("#invoice-#{@invoice3.id}") do
        expect(page).to have_content(@invoice3.id)
        expect(page).to have_link("#{@invoice3.id}")
      end

      within("#invoice-#{@invoice4.id}") do
        expect(page).to have_content(@invoice4.id)
        expect(page).to have_link("#{@invoice4.id}")
      end

      within("#invoice-#{@invoice6.id}") do
        expect(page).to have_content(@invoice6.id)
        expect(page).to have_link("#{@invoice6.id}")
      end
    end
  end

  describe 'Admin Dashboard Invoices sorted by least recent' do
    # As an admin,
    # When I visit the admin dashboard
    # In the section for "Incomplete Invoices",
    # Next to each invoice id I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest

    it 'has the date for invocies created at' do

      within('#incomplete') do
        expect(page).to have_content('Incomplete Invoices')
      end

      within("#invoice-#{@invoice1.id}") do
        expect(page).to have_content("#{@invoice1.id}: #{@invoice1.created_at.strftime("%A, %B, %d, %Y")}")
      end
      
       within("#invoice-#{@invoice2.id}") do
        expect(page).to have_content("#{@invoice2.id}: #{@invoice2.created_at.strftime("%A, %B, %d, %Y")}")
      end

       within("#invoice-#{@invoice3.id}") do
        expect(page).to have_content("#{@invoice3.id}: #{@invoice3.created_at.strftime("%A, %B, %d, %Y")}")
      end

       within("#invoice-#{@invoice4.id}") do
        expect(page).to have_content("#{@invoice4.id}: #{@invoice4.created_at.strftime("%A, %B, %d, %Y")}")
      end

       within("#invoice-#{@invoice6.id}") do
        expect(page).to have_content("#{@invoice6.id}: #{@invoice6.created_at.strftime("%A, %B, %d, %Y")}")
      end
    

    end

    it 'has the list of items ordored by date' do
      within('#incomplete') do
        expect("#{@invoice1.id}").to appear_before("#{@invoice2.id}")
        expect("#{@invoice2.id}").to appear_before("#{@invoice3.id}")
        expect("#{@invoice3.id}").to appear_before("#{@invoice4.id}")
        expect("#{@invoice4.id}").to appear_before("#{@invoice6.id}")
      end
    end
  end
end
