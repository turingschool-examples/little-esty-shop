require 'rails_helper'

RSpec.describe 'merchants invoices show page' do
  it 'displays information and attributes of an invoice' do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
    
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at_date)
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
  end
end
