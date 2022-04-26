require 'rails_helper'

RSpec.describe 'New Merchant Bulk Discount Page', type: :feature do

  before :each do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant1.id}
    @item2 = create :item, {merchant_id: @merchant1.id}
    @item3 = create :item, {merchant_id: @merchant2.id}
    @bulk_discount1 = create :bulk_discount, {merchant_id: @merchant1.id}
    @bulk_discount2 = create :bulk_discount, {merchant_id: @merchant1.id}
    @bulk_discount3 = create :bulk_discount, {merchant_id: @merchant1.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
  end

  it 'Links from Merchant Bulk Discount Index to new Merchant Bulk Discount Page' do
    visit merchant_bulk_discounts_path(@merchant2.id)

    click_link "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant2.id))
  end

  it 'Allows a user to create a new bulk discount for a merchant' do
    visit new_merchant_bulk_discount_path(@merchant2.id)

    fill_in "Percentage",	with: 15
    fill_in "Quantity", with: 3
    click_on "Submit"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant2.id))

    within "#discounts" do
      expect(page).to have_content("15% off if you purchase 3 or more of an item.")
      expect(page).to_not have_content("Discount #{@bulk_discount1.id}: #{@bulk_discount1.percentage_discount}% off if you purchase #{@bulk_discount1.quantity_threshold} or more of an item.")
      expect(page).to_not have_content("Discount #{@bulk_discount2.id}: #{@bulk_discount2.percentage_discount}% off if you purchase #{@bulk_discount2.quantity_threshold} or more of an item.")
      expect(page).to_not have_content("Discount #{@bulk_discount3.id}: #{@bulk_discount3.percentage_discount}% off if you purchase #{@bulk_discount3.quantity_threshold} or more of an item.")
    end
  end
end