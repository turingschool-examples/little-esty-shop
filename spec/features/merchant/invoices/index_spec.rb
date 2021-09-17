require 'rails_helper'

RSpec.describe "merchant invoices index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, customer: @customer_1, )
    @invoice_2 = create(:invoice, customer: @customer_1, )
    @invoice_3 = create(:invoice, customer: @customer_1, )
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "shipped")
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_2, item: @item_1, status: "shipped")
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_3, item: @item_1, status: "shipped")
    # @invoice_2 = create()
    # @invoice_3 = create()
  end

  it 'shows all invoices for a merchant with items' do
    visit merchant_invoices_path(@merchant_1)
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    click_link(@invoice_1.id)
    expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
  end
end
