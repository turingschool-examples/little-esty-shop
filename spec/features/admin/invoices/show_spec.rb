require 'rails_helper'

RSpec.describe 'Admin Invoice Show page' do
before :each do
  @customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
  @invoice_1 = Invoice.create(id: 1, customer_id: @customer_1.id, status: 'cancelled')
  end

  it 'shows invoice information' do
    visit "/admin/invoices/#{@invoice_1.id}"
    save_and_open_page
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")

  end
end
