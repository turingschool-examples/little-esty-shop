require 'rails_helper'

RSpec.describe 'Merchant invoices index page' do

  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @cust7 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @item4 = create(:item, merchant: @merch2)
    @item5 = create(:item, merchant: @merch2)
    @item6 = create(:item, merchant: @merch2)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    @invoice7 = create(:invoice, customer: @cust7)
    @invoice8 = create(:invoice, customer: @cust7)
    InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    InvoiceItem.create(item: @item1, invoice: @invoice4)
    InvoiceItem.create(item: @item1, invoice: @invoice5)
    InvoiceItem.create(item: @item4, invoice: @invoice6)
    InvoiceItem.create(item: @item5, invoice: @invoice7)
    InvoiceItem.create(item: @item6, invoice: @invoice8)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
  end

  it 'shows all the invoices that include one of the merchants items' do
    visit "/merchants/#{@merch1.id}/invoices"

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_content(@invoice3.id)
    expect(page).to have_content(@invoice4.id)
    expect(page).to have_content(@invoice5.id)
  end



end
