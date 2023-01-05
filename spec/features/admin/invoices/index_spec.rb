require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
  it 'Displays all invoice IDs, each one links to the invoice show page' do
    visit admin_invoices_path

    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.last.id)

    click_link("Invoice ID #{Invoice.first.id}")  
    
    expect(current_path).to eq(admin_invoice_path(Invoice.first.id))
  end
end