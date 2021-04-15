require 'rails_helper'

RSpec.describe "Merchanct Invoices Index" do
  before(:each) do
    visit "/merchant/#{@merchant.id}/invoices"
  end
end






# Merchant Invoices Index
#
# As a merchant,
# When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page
