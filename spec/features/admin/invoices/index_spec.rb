require 'rails_helper'

RSpec.describe 'Admin_Invoices Index page' do
  it 'shows all of the invoices that include at least one of the merchants items with a link to that invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)
    item = create(:item_with_invoices, invoices: [invoice_1], invoice_item_unit_price: 13000)
    item2 = create(:item_with_invoices, invoices: [invoice_2], invoice_item_unit_price: 13000)
    item3  = create(:item_with_invoices, invoices: [invoice_3], invoice_item_unit_price: 13000)
    visit "admin/invoices"

    expect(page).to have_content(invoice_1.id)
    click_on(invoice_1.id)
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end
end
