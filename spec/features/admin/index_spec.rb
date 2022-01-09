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

#   As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page
  describe "Incomplete Invoices" do
    before(:each) do
      @merch_1 = Merchant.create!(name: "Shop Here")

      @item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{@merch_1.id}")
      @item_2 = Item.create!(name:"hula hoop", description:"Get your groove on!", unit_price:700, merchant_id:"#{@merch_1.id}")

      @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")

      @invoice_1 = Invoice.create!(customer_id:"#{@cust_1.id}", status:0)
      @invoice_2 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
      @invoice_3 = Invoice.create!(customer_id:"#{@cust_1.id}", status:2)

      @invoice_item_1 = InvoiceItem.create!(invoice_id:"#{@invoice_1.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
      @invoice_item_2 = InvoiceItem.create!(invoice_id:"#{@invoice_2.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
      @invoice_item_3 = InvoiceItem.create!(invoice_id:"#{@invoice_3.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
    end

    it "lists all Incomplete Invoices Ids" do
      visit admin_index_path

      expect(page).to_not have_content(@invoice_2.id)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_3.id)
    end

    xit "shows Incomplete Invoice Ids as links to that invoices admin show page" do
      visit admin_index_path

      click_link "#{@invoice_1.id}"

      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
  end
end
