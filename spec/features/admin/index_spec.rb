require 'rails_helper'

RSpec.describe 'admin index page' do
  it 'has a header indicating the user is on the admin dashboard' do
    visit "/admin"

    expect(page).to have_content('Admin Dashboard Page')
  end

  it 'has links to admin merchants and admin invoices indexes' do
    visit '/admin'

    click_on("Admin Merchants")
    expect(current_path).to eq("/admin/merchants")

    visit '/admin'

    click_on("Admin Invoices")
    expect(current_path).to eq("/admin/invoices")
  end

  it 'lists all incomplete invoices as links' do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled')
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress')
    @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed')
    @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_1.id)
    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1200, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 1200, status: "shipped")
    @invoice_item_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 3, unit_price: 1200, status: "shipped")
    visit '/admin'
    within('#incomplete_invoices') do
      expect(page).not_to have_content(@invoice_3.id)
      click_link "#{@invoice_1.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
    visit '/admin'
    within('#incomplete_invoices') do
      expect(page).to have_content(@invoice_2.id)
      click_on "#{@invoice_2.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
    end
  end

  it 'lists all incomplete invoices as links in order by created_at (oldest first)' do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress', created_at: "2013-03-25 09:54:09 UTC")
    @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed', created_at: "2011-03-25 09:54:09 UTC")
    @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_1.id)
    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1200, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 1200, status: "shipped")
    @invoice_item_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 3, unit_price: 1200, status: "shipped")
    visit '/admin'
    expect(@invoice_1.created_at).to appear_before(@invoice_2.created_at)
    within('#incomplete_invoices') do
      expect(page).not_to have_content(@invoice_3.id)
      click_link "#{@invoice_1.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
    visit '/admin'
    within('#incomplete_invoices') do
      expect(page).to have_content(@invoice_2.id)
      click_on "#{@invoice_2.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
    end

  end
end
