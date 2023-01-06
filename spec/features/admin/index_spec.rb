require 'rails_helper'
require 'rake'

RSpec.describe 'admin index page' do
  before :each do
    FactoryBot.reload
    @customers = FactoryBot.create_list(:customer_with_invoice, 10)
    @invoices = Invoice.all
    FactoryBot.create_list(:transaction, 6, result: 'success', invoice_id: @invoices[0].id)
    FactoryBot.create_list(:transaction, 5, result: 'success', invoice_id: @invoices[3].id)
    FactoryBot.create_list(:transaction, 4, result: 'success', invoice_id: @invoices[1].id)
    FactoryBot.create_list(:transaction, 3, result: 'success', invoice_id: @invoices[4].id)
    FactoryBot.create_list(:transaction, 2, result: 'success', invoice_id: @invoices[2].id)
  end
  
  describe 'header' do
    it 'indicates we are on admin dashboard with header' do
      visit admin_index_path

      within('header') do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'has links to admin merchants and admin invoices' do
      visit admin_index_path

      within('header') do
        expect(page).to have_link("Merchants", href: admin_merchants_path)
        expect(page).to have_link("Invoices", href: admin_invoices_path)
      end
    end
  end

  describe 'top customers' do
    it 'lists the top 5 customers by number of successful transactions' do
      visit admin_index_path

      expect(page).to have_content("Top Customers")
      within("#top-cust") do
        expect(page).to have_content(Customer.top_customers.first.first_name)
        expect(page).to have_content(Customer.top_customers.first.last_name)
        expect(page).to have_content(Customer.top_customers.first.purchases)
      end
    end
  end
end