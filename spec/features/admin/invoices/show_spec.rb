require 'rails_helper'

RSpec.describe 'admin invoice show page' do
  before(:each) do
    @invoice = FactoryBot.create(:invoice)

    visit "/admin/invoices/#{@invoice.id}"
  end

  it 'shows invoice id' do
    expect(page).to have_content(@invoice.id)
  end

  it 'shows invoice status' do
    expect(page).to have_content(@invoice.status)
  end

  it 'shows invoice created_at in correct format' do
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %-d, %Y"))
  end

  it 'shows invoice customer first_name and last_name' do
    expect(page).to have_content(@invoice.customer_name)
  end
end
