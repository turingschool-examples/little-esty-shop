require 'rails_helper'

RSpec.describe 'Admin Dashboard Index page' do
  it 'shows admin header' do
    visit admin_index_path

    expect(page).to have_content("Welcome to Admin Dashboard")
  end

  it 'shows links to admin merchants index' do
    visit admin_index_path

    expect(page).to have_link("Admin Merchants Index")
    click_link "Admin Merchants Index"
    expect(current_path).to eq(admin_merchants_path)
  end

  it 'shows links to admin invoices index' do
    visit admin_index_path

    expect(page).to have_link("Invoices")
    click_link "Invoices"
    expect(current_path).to eq(admin_invoices_path)
  end

  describe "Incomplete Invoices" do
    it "lists all Incomplete Invoices Ids" do
      cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")

      invoice_1 = Invoice.create!(customer_id:"#{cust_1.id}", status:0)
      invoice_2 = Invoice.create!(customer_id:"#{cust_1.id}", status:1)
      invoice_3 = Invoice.create!(customer_id:"#{cust_1.id}", status:0)

      visit admin_index_path

      expect(page).to_not have_content(invoice_2.id)

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_3.id)
    end

    it "shows Incomplete Invoice Ids as links to that invoices admin show page" do
      cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")

      invoice_1 = Invoice.create!(customer_id:"#{cust_1.id}", status:0)
      invoice_2 = Invoice.create!(customer_id:"#{cust_1.id}", status:1)
      invoice_3 = Invoice.create!(customer_id:"#{cust_1.id}", status:0)

      visit admin_index_path

      click_link "#{invoice_1.id}"

      expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
    end
  end
end
