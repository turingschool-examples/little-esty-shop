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

    visit admin_index_path
  end
  
  describe 'header' do
    it 'indicates we are on admin dashboard with header' do
      within('header') do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'has links to admin merchants and admin invoices' do
      within('header') do
        expect(page).to have_link("Merchants", href: admin_merchants_path)
        expect(page).to have_link("Invoices", href: admin_invoices_path)
      end
    end
  end

  describe 'top customers' do
    it 'lists the top 5 customers by number of successful transactions' do
      expect(page).to have_content("Top Customers")

      within("#top-cust") do
        expect(page).to have_content(Customer.top_customers.first.first_name)
        expect(page).to have_content(Customer.top_customers.first.last_name)
        expect(page).to have_content(Customer.top_customers.first.purchases)
      end
    end
  end

  describe 'incomplete invoices' do
    # Admin Dashboard Incomplete Invoices

    # As an admin,
    # When I visit the admin dashboard
    # Then I see a section for "Incomplete Invoices"
    # In that section I see a list of the ids of all invoices
    # That have items that have not yet been shipped
    # And each invoice id links to that invoice's admin show page
    
    it 'shows the incomplete invoices with links to their invoice admin show page' do
      invoice_1 = Invoice.incomplete.first
      invoice_2 = Invoice.incomplete.second
      invoice_3 = Invoice.incomplete.third
      
      within("#incomplete-invoices") do
        expect(page).to have_link(invoice_1.id.to_s, href: admin_invoices_show_path(invoice_1))
        expect(page).to have_link(invoice_2.id.to_s, href: admin_invoices_show_path(invoice_2))
        expect(page).to have_link(invoice_3.id.to_s, href: admin_invoices_show_path(invoice_3))
      end
    end
  end
end
