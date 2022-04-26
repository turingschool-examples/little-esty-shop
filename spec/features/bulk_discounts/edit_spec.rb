require 'rails_helper'

RSpec.describe 'Edit Bulk Discount Page', type: :feature do

  before :each do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant1.id}
    @item2 = create :item, {merchant_id: @merchant1.id}
    @item3 = create :item, {merchant_id: @merchant2.id}
    @bulk_discount1 = create :bulk_discount, {merchant_id: @merchant1.id, percentage_discount: 25, quantity_threshold: 2}
    @bulk_discount2 = create :bulk_discount, {merchant_id: @merchant1.id}
    @bulk_discount3 = create :bulk_discount, {merchant_id: @merchant1.id}
    @bulk_discount4 = create :bulk_discount, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
  end

  it 'Allows a user to edit an individual bulk discount' do
    visit merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id)

    click_link "Edit Discount"

    fill_in :percentage_discount,	with: 15
    fill_in :quantity_threshold, with: 3
    click_on :submit
    
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id))

    expect(page).to_not have_content("Percentage Discount: #{@bulk_discount1.percentage_discount}%")
    expect(page).to have_content("Percentage Discount: 15%")
    expect(page).to_not have_content("Minimum # of Items: #{@bulk_discount1.quantity_threshold}")
    expect(page).to have_content("Minimum # of Items: 3")

    expect(page).to have_link("Edit Discount", href: edit_merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id ))
  end
end