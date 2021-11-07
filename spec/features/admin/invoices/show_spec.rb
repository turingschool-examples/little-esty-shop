require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe "admin index show page" do
  before :each do
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, created_at: "2012-03-25 09:54:09 UTC")
  end

  it 'show invoice information' do
    visit "/admin/invoices/#{@invoice.id}"

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)

    expect(page).to have_content("Sunday, March 25, 2012")

    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end
end