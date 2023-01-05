require 'rails_helper'

RSpec.describe 'Admin Invoice Show' do
  it 'Displays invoice ID, status, created_at, and customer first/last name' do
    visit admin_invoice_path(Invoice.first.id)

    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.first.status)
    expect(page).to have_content(Invoice.first.created_at.strftime('%A, %B %-d, %Y'))
    expect(page).to have_content(Invoice.first.customer.first_name)
    expect(page).to have_content(Invoice.first.customer.first_name)

    expect(page).to_not have_content(Invoice.last.id)
    expect(page).to_not have_content(Invoice.last.customer.first_name)
    expect(page).to_not have_content(Invoice.last.customer.first_name)
  end
end