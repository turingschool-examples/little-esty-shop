require 'rails_helper'

RSpec.describe "The Merchant Invoice show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Korbanth')
    @merchant2 = Merchant.create!(name: 'asdf')

    @item1 = @merchant1.items.create!(
      name: 'SK2',
      description: "Starkiller's lightsaber from TFU2 promo trailer",
      unit_price: 25_000)
    @item2 = @merchant1.items.create!(
      name: 'Shtok eco',
      description: "Hilt side lit pcb",
      unit_price: 1_500)
    @item3 = @merchant1.items.create!(
      name: 'Hat',
      description: "Signed by MJ",
      unit_price: 60_000)
    @item4 = @merchant2.items.create!(
      name: 'what',
      description: "testy",
      unit_price: 10_000)

    @customer1 = Customer.create!(
      first_name: 'Ben',
      last_name: 'Franklin')

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer1.invoices.create!(status: 1)

    @invoice_item1 = InvoiceItem.create!(
      item: @item1,
      invoice: @invoice1,
      quantity: 1,
      unit_price: 1_500,
      status: 0)
    @invoice_item2 = InvoiceItem.create!(
      item: @item2,
      invoice: @invoice1,
      quantity: 1,
      unit_price: 25_000,
      status: 1)
    @invoice_item3 = InvoiceItem.create!(
      item: @item3,
      invoice: @invoice2,
      quantity: 1,
      unit_price: 60_000,
      status: 1)
    @invoice_item4 = InvoiceItem.create!(
      item: @item4,
      invoice: @invoice2,
      quantity: 1,
      unit_price: 60_000,
      status: 1)

    visit merchant_invoice_path(@merchant1.id, @invoice1.id)
  end

  it 'displays all of the items on the invoice and only those items' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
    expect(page).to_not have_content(@item4.name)
  end

  it 'displays the quantity of the item ordered' do
    expect(page).to have_content(@invoice_item1.quantity)
    expect(page).to have_content(@invoice_item2.quantity)

  end

  it 'displays the price that the item sold for' do
    expect(page).to have_content("$1,500.00")
    expect(page).to have_content("$25,000.00")
  end

  it 'displays the invoice item status' do
    expect(page).to have_content(@invoice_item1.status)
    expect(page).to have_content(@invoice_item2.status)
  end

  it 'does not display information for items related to other merchants' do
    expect(page).to_not have_content(@item4.name)
  end

  it 'has a dropdown to change the invoice item status' do
    expect(page).to have_button('Update Item Status')
  end

  it 'actually changes the invoice item status' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content("packaged")

    within("div#id-#{@invoice_item1.id}") do
      select "shipped", :from => "status"
      click_button("Update Item Status")
      expect(page).to have_content("shipped")
      expect(@invoice_item1.status).to eq("shipped")
    end


  end
end
