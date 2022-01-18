require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 1)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 1)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 1)}
  let!(:item_4) {merchant_1.items.create!(name: 'Green Pebble', description: 'Shiny rock', unit_price: 1)}

  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 10, unit_price: 1, status: 'shipped', created_at: Time.new(2021))}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 20, unit_price: 1, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 30, unit_price: 1, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 5, unit_price: 1, status: 'pending', created_at: Time.new(2021))}

  let!(:discount_1) {Discount.create!(percent_off: 10, min_quantity: 10, merchant_id: merchant_1.id)}
  let!(:discount_2) {Discount.create!(percent_off: 20, min_quantity: 20, merchant_id: merchant_1.id)}
  let!(:discount_3) {Discount.create!(percent_off: 30, min_quantity: 30, merchant_id: merchant_1.id)}



  it 'can return correct discount for item' do
    expect(invoice_item_1.item_discount(invoice_item_1.id)).to eq(discount_1)
  end
end
