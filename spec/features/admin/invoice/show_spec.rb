require 'rails_helper'
describe 'Admin Invoice Show Page' do
  before :each do
    @customer = create(:customer)
    @merchant = create(:merchant)
    @invoice = create(:invoice, customer_id: @customer.id)
    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)
    @invoice_item1 = create(:invoice_item, invoice_id: @invoice.id, item_id: @item1.id)
  end

  it 'Sees Invoice and attributes' do
    visit admin_invoice_path(@invoice)

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
  end

  it "Sees Customer Information" do
    visit admin_invoice_path(@invoice)

    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it "Sees All Items on Invoice" do
    visit admin_invoice_path(@invoice)

    expect(page).to have_content(@item1.name)
    expect(page).to_not have_content(@item2.name)
    expect(page).to have_content(@invoice_item1.quantity)
    expect(page).to have_content(@invoice_item1.unit_price)
    expect(page).to have_content(@invoice_item1.status)
  end

  it "Sees an Invoice's Total Revenue" do
    visit admin_invoice_path(@invoice)

    expect(page).to have_content(@invoice.total_revenue)
  end

  it 'sees select feild for invoice status' do
    visit admin_invoice_path(@invoice)

    select("completed", from: 'status')
    expect(page).to have_button("Submit")
    click_on('Submit')
    expect(current_path).to eq(admin_invoice_path(@invoice))
    expect(@invoice.status).to eq('completed')
    expect(page).to have_content(@invoice.name)
  end
end
