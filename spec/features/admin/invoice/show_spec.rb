require 'rails_helper'
describe 'Admin Invoice Show Page' do
  before :each do
    @customer = create(:customer)
    @invoice = create(:invoice, customer_id: @customer.id)
  end

  it 'Sees Invoice and attributes' do
    visit admin_invoice_path(@invoice)

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at)
  end
end