# As a merchant,
# When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page
require 'rails_helper'

RSpec.describe "Merchant invoice index" do

  it 'I see all of the invoices that include at least one of my merchants items' do
    visit "/merchants/#{@merchant_1.id}/invoices"
    expect(page).to have_content(@invoice_1.id)
  end
end