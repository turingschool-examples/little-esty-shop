require 'rails_helper'

RSpec.describe 'admin invoices index page' do
  it 'has all invoice ids as links' do
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)

    visit admin_invoices_path

    expect(page).to have_link("#{invoice_1.id}")
    expect(page).to have_link("#{invoice_2.id}")
  end

  it "invoice id links to show page" do
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)

    visit admin_invoices_path
    click_link("#{invoice_1.id}")

    expect(current_path).to eq(admin_invoice_path(invoice_1.id))
  end
end
