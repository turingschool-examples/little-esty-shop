require 'rails_helper'

RSpec.describe "merchant invoices show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021" )
    @invoice_2 = create(:invoice, customer: @customer_1, created_at: "Thursday, September 16, 2021")
    @invoice_3 = create(:invoice, customer: @customer_1, created_at: "Wednesday, September 15, 2021")
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "shipped")
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, status: "shipped")
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_3, status: "pending")

  end

  it 'shows invoice information' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.date)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'shows all items on the invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_2.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_2.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
    expect(page).to have_content(@invoice_item_2.status)

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@invoice_item_3.quantity)
    expect(page).to_not have_content(@invoice_item_3.unit_price)
    expect(page).to_not have_content(@invoice_item_3.status)
  end
end
