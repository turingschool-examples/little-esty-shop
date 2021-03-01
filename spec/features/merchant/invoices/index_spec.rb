require 'rails_helper'

RSpec.describe 'the merchant invoice index page' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id)

    @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
    @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
    @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
    @invoice4 = create(:invoice, created_at: "2020-02-20 09:54:09 UTC")
    @invoice5 = create(:invoice, created_at: "2019-05-12 09:54:09 UTC")
    @invoice6 = create(:invoice, created_at: "2015-12-25 09:54:09 UTC")

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 2, quantity: 6, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 1, unit_price: 100)
  end

  it 'displays all invoice ids as links' do
    visit merchant_invoices_path(@merchant1)

    expect(page).to have_link(@invoice1.id)
    expect(page).to have_link(@invoice2.id)
    expect(page).to have_link(@invoice3.id)
    expect(page).to have_link(@invoice4.id)
    expect(page).to have_link(@invoice5.id)
    expect(page).to have_link(@invoice6.id)

    click_on "#{@invoice1.id}"
    expect(current_path).to eq(merchant_invoice_path( @merchant1.id, @invoice1.id ))
  end
end
