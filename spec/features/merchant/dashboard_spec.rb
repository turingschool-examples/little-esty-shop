require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/dashboard'" do
  before :each do
    @merchant1 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id)

    @invoice_item = create(:invoice_item_with_invoices, item_id: @item.id)
    @invoice_item2 = create(:invoice_item_with_invoices, item_id: @item2.id)
    @invoice_item3 = create(:invoice_item_with_invoices, item_id: @item3.id)
    @invoice_item4 = create(:invoice_item_with_invoices, item_id: @item4.id)
    @invoice_item5 = create(:invoice_item_with_invoices, item_id: @item5.id)
    @invoice_item6 = create(:invoice_item_with_invoices, item_id: @item6.id)

    @transactions = create_list(:transaction, 6, invoice_id: @invoice_item.invoice.id, result: "success")
    @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: "success")
    @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: "success")
    @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: "success")
    @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: "success")
    @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: "failed")

    @customer = @invoice_item.invoice.customer
    @customer2 = @invoice_item2.invoice.customer
    @customer3 = @invoice_item3.invoice.customer
    @customer4 = @invoice_item4.invoice.customer
    @customer5 = @invoice_item5.invoice.customer
    @customer6 = @invoice_item6.invoice.customer
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

    within("#top-customers") do
      expect(page).to have_content(@customer.name)
      expect(page).to have_content(@customer2.name)
      expect(page).to have_content(@customer3.name)
      expect(page).to have_content(@customer4.name)
      expect(page).to have_content(@customer5.name)
      expect(page).not_to have_content(@customer6.name)

      expect(@customer5.name).to appear_before(@customer4.name)
      expect(@customer4.name).to appear_before(@customer3.name)
      expect(@customer3.name).to appear_before(@customer2.name)
      expect(@customer2.name).to appear_before(@customer.name)
    end

    within("#customer-#{@customer5.id}") do
      expect(page).to have_content("Successful Transactions: 10")
    end
  end
end

# Merchant Dashboard Statistics - Favorite Customers
#
# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
