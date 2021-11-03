require 'rails_helper'

RSpec.describe 'index page' do
  before(:each) do
    @merchant = Merchant.first
    visit "/merchants/#{@merchant.id}/invoices"
  end

  it "shows all invoices that include the given merchant's items" do

    expect(page).to have_content(@merchant.invoice_ids.first)
    expect(page).to have_content(@merchant.invoice_ids.last)
  end
end
