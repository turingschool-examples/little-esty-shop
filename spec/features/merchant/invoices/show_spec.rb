require 'rails_helper'

RSpec.describe "merchant invoices show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1, name: "A")
    @item_2 = create(:item, merchant: @merchant_1, name: "B")
    @item_3 = create(:item, merchant: @merchant_2, name: "C")
    @item_4 = create(:item, merchant: @merchant_2, name: "D")
    @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021", id: 555 )
    @invoice_2 = create(:invoice, customer: @customer_1, created_at: "Thursday, September 16, 2021", id: 111)
    @invoice_3 = create(:invoice, customer: @customer_1, created_at: "Wednesday, September 15, 2021", id: 222)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "pending", unit_price: 5, quantity: 1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_1, status: "shipped", unit_price: 5, quantity: 5)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_1, status: "shipped", unit_price: 4, quantity: 4)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_1, item: @item_2, status: "packaged", unit_price: 5, quantity: 5)
  end

  it 'shows invoice information' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.date)
    expect(page).to have_content(@invoice_1.customer_name)
  end

  it "will show the total revenue for all items on the invoice" do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.revenue)
  end

  it 'shows all items on the invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_4.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_4.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
    expect(page).to have_content(@invoice_item_4.status)

    expect(page).to_not have_content(@invoice_item_3.quantity)
    expect(page).to_not have_content(@invoice_item_3.unit_price)
  end

  it 'shows a select field for each invoice item status' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@item_1.name)
    within("#status-#{@invoice_item_1.id}") do
      select("pending", from: "invoice_item_status")
      click_on("Update Item Status")
    end
    expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
    expect(page).to have_content("packaged")
  end
end
