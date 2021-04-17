require 'rails_helper'

RSpec.describe 'as a merchant, when I click on the id of an invoice' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: :pending, quantity: 1, unit_price: 30)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: :pending, quantity: 5, unit_price: 20)
    @invoice_item_3 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, status: :pending, quantity: 10, unit_price: 10)
    @invoice_item_4 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, status: :packaged, quantity: 20, unit_price: 5)

  end

  it "I am taken to that merchant's invoice's show page and I see all of the invoice's attributes" do
    visit merchant_invoices_path(@merchant_1)
    click_on("Invoice ##{@invoice_1.id}")

    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)

    expect(page).to_not have_content(@invoice_2.id)
  end

  it "The invoice created_at date is formatted 'Monday, July 18, 2019'" do
    visit merchant_invoices_path(@merchant_1)

    click_on("Invoice ##{@invoice_1.id}")

    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

    expect(page).to have_content(@invoice_1.formatted_date)
  end

  it "displays the customer's first and last names" do
    visit merchant_invoices_path(@merchant_1)

    click_on("Invoice ##{@invoice_1.id}")

    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)

    expect(page).to_not have_content(@invoice_2.customer.first_name)
    expect(page).to_not have_content(@invoice_2.customer.last_name)
  end
end
