RSpec.describe 'Merchant Invoice Index' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice_items1 = create(
      :invoice_item, item_id: @item1.id,
      invoice_id: @invoice1.id
    )
    @item2 = create(:item, merchant_id: @merchant1.id)
    @customer2 = create(:customer)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice_items2 = create(
      :invoice_item, item_id: @item2.id,
      invoice_id: @invoice2.id
    )
  end

  it 'shows all the attributes of the invoices and provides links to each invoice show page' do

    visit "/merchants/#{@merchant1.id}/invoices"

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_link("Link to this invoice")
  end
end
