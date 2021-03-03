require 'rails_helper'
describe 'Admin Dashboard' do
  before :each do
    @customers = []
    10.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant2.id)

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers.fifth.invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[6].invoices.first

    9.times {create(:transaction, invoice_id: @invoice_1.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_2.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_4.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    10.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}
    @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @item1.id, status: 0)
    @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @item2.id, status: 0)
    @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @item3.id, status: 1)
    @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, status: 2)
  end

  it 'displays a header' do
    visit admin_index_path

    expect(page).to have_content("Admin Dashboard")
  end

  it 'Shows links to merchant and invoice index pages' do
    visit admin_index_path

    expect(page).to have_link("Merchant Index")
    expect(page).to have_link("Invoice Index")
  end

  it 'Shows names of top 5 customers with largest number of transactions' do
    visit admin_index_path

    expect(@customers.first.first_name).to appear_before(@customers.second.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.second.last_name)
    expect(@customers.first.first_name).to appear_before(@customers.third.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.third.last_name)
    expect(@customers.first.first_name).to appear_before(@customers.fourth.first_name)
    expect(@customers.first.last_name).to appear_before(@customers.fourth.last_name)
    expect(page).to_not have_content(@customers[6].first_name)
    expect(page).to_not have_content(@customers[6].last_name)
  end

  it 'shows incomplete invoices and thier attributes' do
    visit admin_index_path

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_link(@invoice_3.id)
    expect(page).to have_link(@invoice_2.id)
    expect(page).to_not have_content(@invoice_4.id)
    click_link(@invoice_1.id)
    expect(current_path).to eq(admin_invoice_path(@invoice_1))
  end
end
