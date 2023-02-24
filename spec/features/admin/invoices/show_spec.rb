require 'rails_helper'


describe 'admin invoice show page' do

  it 'has a header saying it is a show page' do
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id)
    visit "/admin/invoices/#{invoice.id}"
    expect(page).to have_content("Invoice id: #{invoice.id} Show Page")
  end
end