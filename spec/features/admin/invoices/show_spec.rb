require 'rails_helper'

RSpec.describe 'admin invoices show page' do
  it 'has all invoice ids as links' do
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)

    visit "/admin/invoices/#{invoice_1.id}"

    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("#{invoice_1.status}")
    expect(page).to have_content("#{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{invoice_1.customer.first_name}")
    expect(page).to have_content("#{invoice_1.customer.last_name}")
  end

end
