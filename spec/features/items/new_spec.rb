require "rails_helper"

describe "New Items", type: :feature do
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

  it "links to item create page", :vcr do
    visit merchant_items_path(@merchant2)

    expect(page).to have_link("Add new item")
    click_link("Add new item")

    expect(page).to have_current_path(new_merchant_item_path(@merchant2))
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit price')
  end

  it "has form for new item", :vcr do
    visit merchant_items_path(@merchant2)
    click_link("Add new item")

    fill_in 'Name', with: "This new item"
    fill_in 'Description', with: 'New item'
    fill_in 'Unit price', with: 2
    click_button 'Submit'

    expect(page).to have_current_path(merchant_items_path(@merchant2))
    expect(page).to have_content("This new item")
  end
end
