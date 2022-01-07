require 'rails_helper'

RSpec.describe 'Admin_Invoices Index page' do
  it 'shows all of the invoices that include at least one of the merchants items with a link to that invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)
    visit "admin/invoices"
    # save_and_open_page
    expect(page).to have_content(invoice_1.id)
    click_on(invoice_1.id)
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end
end
