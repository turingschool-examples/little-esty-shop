# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard' do
  describe 'user story 19' do
    it 'should have a header \'admin dashboard\'' do
      visit '/admin'
      within('header') do
        expect(page).to have_css('h1', text: 'Admin Dashboard')
      end
    end
  end

  describe 'user story 20' do
    it 'should have a link to admin merchants index' do
      visit '/admin'
      expect(page).to have_link('Admin Merchants', href: '/admin/merchants')
    end

    it 'should have a link to admin invoices index' do
      visit '/admin'
      expect(page).to have_link('Admin Invoices', href: '/admin/invoices')
    end
  end

  describe 'user story 21' do
    before do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
      @customer4 = create(:customer)
      @customer5 = create(:customer)
      @customer6 = create(:customer)
      @customer7 = create(:customer)
      @customer8 = create(:customer)
      @invoice1 = create(:invoice, customer_id: @customer1.id)
      @invoice2 = create(:invoice, customer_id: @customer2.id)
      @invoice3 = create(:invoice, customer_id: @customer3.id)
      @invoice4 = create(:invoice, customer_id: @customer4.id)
      @invoice5 = create(:invoice, customer_id: @customer5.id)
      @invoice6 = create(:invoice, customer_id: @customer6.id)
      @invoice7 = create(:invoice, customer_id: @customer7.id)
      @invoice8 = create(:invoice, customer_id: @customer8.id)
      @transaction1_1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
      @transaction1_2 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
      @transaction1_3 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
      @transaction2_1 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
      @transaction2_2 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
      @transaction3_1 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
      @transaction3_2 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
      @transaction4_1 = create(:transaction, invoice_id: @invoice4.id, result: 'success')
      @transaction4_2 = create(:transaction, invoice_id: @invoice4.id, result: 'success')
      @transaction5_1 = create(:transaction, invoice_id: @invoice5.id, result: 'success')
      @transaction5_1 = create(:transaction, invoice_id: @invoice5.id, result: 'success')
      @transaction6 = create(:transaction, invoice_id: @invoice6.id)
      @transaction7 = create(:transaction, invoice_id: @invoice7.id)
      @transaction8 = create(:transaction, invoice_id: @invoice8.id)
      visit '/admin'
    end
    it 'should have a list of the top 5 customers' do
      expect(page).to have_content('Top 5 Customers')
      expect(page).to have_content("#{"#{@customer1.first_name} #{@customer1.last_name}"}: 3 transactions")
      expect(page).to have_content("#{"#{@customer2.first_name} #{@customer2.last_name}"}: 2 transactions")
      expect(page).to have_content("#{"#{@customer3.first_name} #{@customer3.last_name}"}: 2 transactions")
      expect(page).to have_content("#{"#{@customer4.first_name} #{@customer4.last_name}"}: 2 transactions")
      expect(page).to have_content("#{"#{@customer5.first_name} #{@customer5.last_name}"}: 2 transactions")
    end
  end

  describe 'incomplete invoices section' do
    before do
      @customer = create(:customer)
      @invoice1 = create(:invoice, customer_id: @customer.id)
      @invoice2 = create(:invoice, customer_id: @customer.id)
      @invoice3 = create(:invoice, customer_id: @customer.id)
      @invoice4 = create(:invoice, customer_id: @customer.id)
      @invoice5 = create(:invoice, customer_id: @customer.id)
      @merchant = create(:merchant)
      @item = create(:item, merchant_id: @merchant.id)
      # StatusKey: 0 => packaged, 1 => pending, 2 => shipped
      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item.id, status: 2)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item.id, status: 0)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item.id, status: 2)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item.id, status: 0)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item.id, status: 1)
      visit '/admin'
    end
    it 'should have a list of invoices that have unshipped items' do
      within('div#incomplete_invoices') do
        expect(page).to have_content('Incomplete Invoices')
        expect(page).to have_content("id: #{@invoice2.id}")
        expect(page).to have_content("id: #{@invoice4.id}")
        expect(page).to have_content("id: #{@invoice5.id}")
      end
    end

    it 'should have links to invoices admin show page' do
      within('div#incomplete_invoices') do
        click_on @invoice2.id.to_s
      end
      expect(current_path).to eq("/admin/invoices/#{@invoice2.id}")
    end

    before do
      Invoice.find(@invoice2.id).update(created_at: Time.new(2002))
      Invoice.find(@invoice4.id).update(created_at: Time.new(2010, 10, 31))
      Invoice.find(@invoice5.id).update(created_at: Time.new(2022))
      visit '/admin'
    end

    it 'list is ordered from oldest to newest' do
      within('div#incomplete_invoices') do
        expect(@invoice2.id.to_s).to appear_before(@invoice4.id.to_s)
        expect(@invoice4.id.to_s).to appear_before(@invoice5.id.to_s)
      end
    end

    it 'has the date next to each invoice' do
      within('div#incomplete_invoices') do
        expect(page).to have_content("id: #{@invoice2.id} Created at: Tuesday, January 01, 2002")
        expect(page).to have_content("id: #{@invoice4.id} Created at: Sunday, October 31, 2010")
        expect(page).to have_content("id: #{@invoice5.id} Created at: Saturday, January 01, 2022")
      end
    end
  end
end
