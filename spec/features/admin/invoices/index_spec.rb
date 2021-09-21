require 'rails_helper'

RSpec.describe 'admin invoice index page' do
  before :each do
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 'cancelled')
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress')
    @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed')
  end

  it 'lists all invoice ids as links to invoice show page' do
    visit "/admin/invoices"

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)

    click_on "#{@invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")

    visit "/admin/invoices"
    click_on "#{@invoice_2.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
    visit "/admin/invoices"
    click_on "#{@invoice_3.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_3.id}")
  end
end
