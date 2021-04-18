require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
  @merchant_1 = create(:merchant, name: "M1")
  @merchant_2 = create(:merchant, name: "M2")
  @merchant_3 = create(:merchant, name: "M3")
  @merchant_4 = create(:merchant, name: "M4")
  @merchant_5 = create(:merchant, name: "M5")

  @customer_1 = FactoryBot.create(:customer)
  @customer_2 = FactoryBot.create(:customer)
  @customer_3 = FactoryBot.create(:customer)
  @customer_4 = FactoryBot.create(:customer)
  @customer_5 = FactoryBot.create(:customer)
  @customer_6 = FactoryBot.create(:customer)

  @item_1 = create(:item, merchant: @merchant_1)
  @item_2 = create(:item, merchant: @merchant_2)
  @item_3 = create(:item, merchant: @merchant_3)
  @item_4 = create(:item, merchant: @merchant_4)
  @item_5 = create(:item, merchant: @merchant_5)

  @invoice_1 = FactoryBot.create(:invoice)
  @invoice_2 = FactoryBot.create(:invoice)
  @invoice_3 = FactoryBot.create(:invoice)
  @invoice_4 = FactoryBot.create(:invoice)
  @invoice_5 = FactoryBot.create(:invoice)
  @invoice_6 = FactoryBot.create(:invoice)

  @customer_1.invoices << [@invoice_1]
  @customer_2.invoices << [@invoice_2]
  @customer_3.invoices << [@invoice_3]
  @customer_4.invoices << [@invoice_4]
  @customer_5.invoices << [@invoice_5]
  @customer_6.invoices << [@invoice_6]

  @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
  @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "pending", quantity: 5, unit_price: 20)
  @invoice_item_3 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, status: "pending", quantity: 10, unit_price: 10)
  @invoice_item_4 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, status: "packaged", quantity: 20, unit_price: 5)
  @invoice_item_5 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 40, unit_price: 5)
  @invoice_item_6 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 60, unit_price: 5)
  @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 80, unit_price: 5)
  @invoice_item_8 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 100, unit_price: 5)