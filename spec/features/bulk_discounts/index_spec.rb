require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index', type: :feature do

  before :each do
    @merchant = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id}
    @item2 = create :item, {merchant_id: @merchant.id}
    @item3 = create :item, {merchant_id: @merchant.id}
    @bulk_discount1 = create :bulk_discount, {merchant_id: @merchant.id}
    @bulk_discount2 = create :bulk_discount, {merchant_id: @merchant.id}
    @bulk_discount3 = create :bulk_discount, {merchant_id: @merchant.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
  end


  it 'Will display all bulk discounts, including links to individual show pages' do
    visit merchant_dashboard_index_path(@merchant.id)

    expect(page).to have_link("View Bulk Discounts", href: merchant_bulk_discounts_path(@merchant.id))

    click_link("View Bulk Discounts")

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant.id))

    within "#discounts" do
      within "#discount-#{@bulk_discount1.id}" do
        expect(page).to have_content("Discount #{@bulk_discount1.id}: #{@bulk_discount1.percentage_discount}% off if you purchase #{@bulk_discount1.quantity_threshold} or more of an item.")
        expect(page).to_not have_content("Discount #{@bulk_discount2.id}: #{@bulk_discount2.percentage_discount}% off if you purchase #{@bulk_discount2.quantity_threshold} or more of an item.")
        expect(page).to_not have_content("Discount #{@bulk_discount3.id}: #{@bulk_discount3.percentage_discount}% off if you purchase #{@bulk_discount3.quantity_threshold} or more of an item.")
        expect(page).to have_link("View Details", href: merchant_bulk_discounts_show_path(@bulk_discount1.id))
      end
      within "#discount-#{@bulk_discount2.id}" do
        expect(page).to_not have_content("Discount #{@bulk_discount1.id}: #{@bulk_discount1.percentage_discount}% off if you purchase #{@bulk_discount1.quantity_threshold} or more of an item.")
        expect(page).to have_content("Discount #{@bulk_discount2.id}: #{@bulk_discount2.percentage_discount}% off if you purchase #{@bulk_discount2.quantity_threshold} or more of an item.")
        expect(page).to_not have_content("Discount #{@bulk_discount3.id}: #{@bulk_discount3.percentage_discount}% off if you purchase #{@bulk_discount3.quantity_threshold} or more of an item.")
        expect(page).to have_link("View Details", href: merchant_bulk_discounts_show_path(@bulk_discount2.id))
      end
      within "#discount-#{@bulk_discount3.id}" do
        expect(page).to_not have_content("Discount #{@bulk_discount1.id}: #{@bulk_discount1.percentage_discount}% off if you purchase #{@bulk_discount1.quantity_threshold} or more of an item.")
        expect(page).to_not have_content("Discount #{@bulk_discount2.id}: #{@bulk_discount2.percentage_discount}% off if you purchase #{@bulk_discount2.quantity_threshold} or more of an item.")
        expect(page).to have_content("Discount #{@bulk_discount3.id}: #{@bulk_discount3.percentage_discount}% off if you purchase #{@bulk_discount3.quantity_threshold} or more of an item.")
        expect(page).to have_link("View Details", href: merchant_bulk_discounts_show_path(@bulk_discount3.id))
      end
    end
  end
end