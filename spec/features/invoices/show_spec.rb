require 'rails_helper'

RSpec.describe 'merchants invoices show page' do
  it 'displays information and attributes of an invoice' do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    merchant_2 = create(:merchant)
    customer_2 = create(:customer)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2 = create(:invoice, customer_id: customer_2.id)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)

    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content("Invoice Information")
    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at_date)
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)

    visit "/merchants/#{merchant_2.id}/invoices/#{invoice_2.id}"

    expect(page).to have_content(invoice_2.id)
    expect(page).to have_content(invoice_2.status)
    expect(page).to have_content(invoice_2.created_at_date)
    expect(page).to have_content(customer_2.first_name)
    expect(page).to have_content(customer_2.last_name)
  end

  it 'displays information for items sold' do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    item_2 = create(:item, merchant_id: merchant_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id)

    item_3 = create(:item, merchant_id: merchant_1.id)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_1.id)

    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content("Invoice Item Information")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(item_1.unit_price)
    expect(page).to have_content(invoice_item_1.status)
  end

  xit 'displays a merchants total revenue' do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    item_2 = create(:item, merchant_id: merchant_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id)

    item_3 = create(:item, merchant_id: merchant_1.id)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_1.id)

    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(invoice_1.total_revenue).to eq(42)
  end
end
