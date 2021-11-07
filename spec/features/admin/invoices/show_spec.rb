require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe "admin index show page" do
  before :each do
    @customer = create(:customer)

    @invoice = create(:invoice, customer: @customer, created_at: "2012-03-25 09:54:09 UTC")

    @item1 = create(:item)
    @item2 = create(:item)

    @invoice_item1 = create(:invoice_item, invoice: @invoice, item: @item1, quantity: 1, unit_price: 1000)
    @invoice_item2 = create(:invoice_item, invoice: @invoice, item: @item2, quantity: 10, unit_price: 200)
  end

  it 'show invoice information' do
    visit "/admin/invoices/#{@invoice.id}"

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)

    expect(page).to have_content("Sunday, March 25, 2012")

    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it 'describes the items for the invoice' do
    visit "/admin/invoices/#{@invoice.id}"

    within('#item-0') do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content("$10.00")

      expect(page).to_not have_content(@item2.name)
    end
  end

  it 'displays the total revenue for the invoice' do
    visit "/admin/invoices/#{@invoice.id}"

    expect(page).to have_content("Total Revenue: $30.00")
  end
end