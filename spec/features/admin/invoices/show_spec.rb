require 'rails_helper'

RSpec.describe "admin/invoices#show" do
  before :each do
    test_data
  end


  it 'has invoice ID' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.id)
  end

  it 'has status' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.status)
  end

  it 'has created at formatted' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@invoice_1.created_at_formatted)
  end

  it 'has customer first and last name' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
  end
end