require 'rails_helper'


describe 'admin invoice show page' do

  before do 
    @customer = create(:customer)
    @invoice = create(:invoice, customer_id: @customer.id)
  end
  it 'has a header saying it is a show page' do
    visit "/admin/invoices/#{@invoice.id}"
    expect(page).to have_content("Invoice id: #{@invoice.id} Show Page")
  end

  it 'has details about the invoice' do
    visit "/admin/invoices/#{@invoice.id}"
    
    expect(page).to have_content('id: ' + @invoice.id.to_s)
    expect(page).to have_content('customer_id: ' + @invoice.customer_id.to_s)
    expect(page).to have_content('status: ' + @invoice.status)
    expect(page).to have_content('created_at: ' + @invoice.created_at.to_s)
    expect(page).to have_content('updated_at: ' + @invoice.updated_at.to_s)
  end
end