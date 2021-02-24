require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/dashboard'" do
  before :each do
    @merchant = create(:merchant, id: 3000)
    @customer = create(:customer, id: 1000)
    @invoice = create(:invoice, id: 2000, customer_id: 1000)
    @transaction = create(:transaction, invoice_id: 2000)
    @item = create(:item, id: 4000, merchant_id: 3000)
    @invoice_item = create(:invoice_item, item_id: 4000, invoice_id: 2000)

    # @customer2 = create(:customer, id: 1001)
    # @customer3 = create(:customer, id: 1002)
    # @customer4 = create(:customer, id: 1003)
    # @customer5 = create(:customer, id: 1004)
    # @customer6 = create(:customer, id: 1005)
    # @invoices1 = create_list(:invoice, 10, customer_id: 1000)
    # @invoices2 = create_list(:invoice, 10, customer_id: 1000)
    # @transactions = create_list(:transaction, 10)

  end

  it "Shows the name of my merchant" do
    binding.pry
    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_content(@merchant1.name)
  end

  it "Shows link to merchant items index and merchant invoice index" do

    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_link("#{@merchant1.name}'s Items Index")
    expect(page).to have_link("#{@merchant1.name}'s Invoices Index")
  end

  it "Shows top 5 customers by successful transactions" do
    visit merchant_dashboard_index_path(@merchant1)


  end
end


# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchant/merchant_id/items)
# And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)
