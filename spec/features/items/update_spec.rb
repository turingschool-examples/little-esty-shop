require "rails_helper"

describe "Merchants Items update", type: :feature do
  before :each do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant1.id}
    @item2 = create :item, {merchant_id: @merchant1.id}
    @item3 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}

  end
  it 'displays update link' do
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

    expect(page).to have_link("Update #{@item1.name}")
    click_link("Update #{@item1.name}")

    expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
  end

  it 'has form to update item' do
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
    click_link("Update #{@item1.name}")

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit price')
    expect(find('form')).to have_content('Enabled')
  end

  it 'updates item info' do
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
    click_link("Update #{@item1.name}")

    fill_in 'Name', with: 'Different Item'
    click_button 'Save'

    expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item1.id}")
    expect(page).to have_content("Different Item")
  end
end
