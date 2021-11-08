# As a merchant,
# When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page


require "rails_helper"

RSpec.describe "merchant's invoices index", type: :feature do
  describe "when I visit my merchant's invoices index" do
    before(:each) do

    end

    it "I see all the invoices that has merchant's items" do
    end

    it "I see invoice_id for each invoice, which links to merchant invoice show page" do
    end

    
  end
end
