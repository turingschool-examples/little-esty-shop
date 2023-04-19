require 'rails_helper'

RSpec.describe "admin/invoices#show" do
  before :each do
    test_data
  end


  it 'has invoice ID' do
    visit admin_invoice(@invoice_1)

    expect(page).to have_content(@invoice_1.id)
  end

  xit 'has status' do
    visit admin_invoice(@invoice_1)

    expect(page).to have_content(@invoice_1.status)
  end

  xit 'has created at formatted' do
    visit admin_invoice(@invoice_1)

    expect(page).to have_content(@invoice_1.created_at_formatted)
  end

  xit 'has customer first and last name' do
    visit admin_invoice(@invoice_1)

    expect(page).to have_content(@invoice_1.id)
  end
end