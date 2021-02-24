require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/dashboard'" do
  before :each do
    @invoice_item = create(:invoice_item_with_invoices, invoice_count: 10)
    @invoice_item2 = create(:invoice_item_with_items, invoice_count: 10)
    @merchant1 = create(:merchant)
  end

  it "Shows the name of my merchant" do
    visit merchant_dashboard_path(@merchant1)

    expect(page).to have_content(@merchant1.name)
  end

  it "Shows link to merchant items index and merchant invoice index" do

    visit merchant_dashboard_path(@merchant1)

    expect(page).to have_link("#{@merchant1.name}'s Items Index")
    expect(page).to have_link("#{@merchant1.name}'s Invoices Index")
  end

  it "Shows top 5 customers by successful transactions" do
    visit merchant_dashboard_path(@merchant1)


  end
end


# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchant/merchant_id/items)
# And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)
