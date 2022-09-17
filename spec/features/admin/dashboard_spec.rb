require 'rails_helper'

RSpec.describe 'admin dashboard page' do

  it 'can visit /admin' do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'can link to admin mechants index' do
    visit '/admin'

    click_link 'Merchants'

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'can link to admin invoices index' do
    visit '/admin'

    click_link 'Invoices'

    expect(current_path).to eq(admin_invoices_path)
  end

  describe 'dashboard statistics' do

    it 'can return list of top 5 customers in descending order of completed invoices' do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
      @customer4 = create(:customer)
      @customer5 = create(:customer)
      @customer6 = create(:customer)
      @invoice_list_1 = create_list(:invoice, 1, customer_id: @customer1.id)
      @failed_invoices_1 = create_list(:invoice, 3, customer_id: @customer1.id)
      @invoice_list_2 = create_list(:invoice, 2, customer_id: @customer2.id)
      @invoice_list_3 = create_list(:invoice, 3, customer_id: @customer3.id)
      @invoice_list_4 = create_list(:invoice, 4, customer_id: @customer4.id)
      @invoice_list_5 = create_list(:invoice, 5, customer_id: @customer5.id)
      @invoice_list_6 = create_list(:invoice, 6, customer_id: @customer6.id)
      invoices = [@invoice_list_1, @invoice_list_2, @invoice_list_3, @invoice_list_4, @invoice_list_5, @invoice_list_6].flatten

      invoices.each do |invoice|
        create(:transaction, invoice_id: invoice.id, result: :success)
      end
      @failed_invoices_1.each do |invoice|
        create(:transaction, invoice_id: invoice.id, result: :failed)
      end

      visit admin_path
      expect(page).to_not have_content(@customer1.name)
      expect(all('.customer')[0].text).to eq("#{@customer6.name} - 6 purchases")
      expect(all('.customer')[1].text).to eq("#{@customer5.name} - 5 purchases")
      expect(all('.customer')[2].text).to eq("#{@customer4.name} - 4 purchases")
      expect(all('.customer')[3].text).to eq("#{@customer3.name} - 3 purchases")
      expect(all('.customer')[4].text).to eq("#{@customer2.name} - 2 purchases")
    end
  end

  describe 'User Story 22 Admin Dashboard Incomplete Invoices' do
    before :each do
      @invoice1 = create(:invoice)
      create_list(:invoiceItem, 5, invoice_id: @invoice1.id, status: :shipped)
      @invoice2 = create(:invoice)
      create_list(:invoiceItem, 3, invoice_id: @invoice2.id, status: :pending)
      create_list(:invoiceItem, 3, invoice_id: @invoice2.id, status: :shipped)
      @invoice3 = create(:invoice)
      create_list(:invoiceItem, 5, invoice_id: @invoice3.id, status: :packaged)
    end

    it 'There is a section with a list of all invoices that have not yet shipped items' do
      visit admin_path
      expect(page).to have_content("Incomplete Invoices")
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
    end

    it 'Each invoice id links to the invoice admin show page' do
      visit admin_path
      click_link @invoice2.id
      expect(current_path).to eq(admin_invoice_path(@invoice2))
      visit admin_path
      click_link @invoice3.id
      expect(current_path).to eq(admin_invoice_path(@invoice3))
    end
  end
end
