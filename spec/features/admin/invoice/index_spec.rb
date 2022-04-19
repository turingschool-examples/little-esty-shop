require "rails_helper"

RSpec.describe Merchant do
  before do
    @merch_2 = Merchant.create!(name: "Store Two")
    @merch_3 = Merchant.create!(name: "Store three")
    @merch_4 = Merchant.create!(name: "Store four")
    @merch_5 = Merchant.create!(name: "Store five")
    @merch_6 = Merchant.create!(name: "Store six")

    @m2_item = @merch_2.items.create!(name: "Merch 2 Item", description: "Item belongs to m2", unit_price: 20000)
    @m3_item = @merch_3.items.create!(name: "Merch 3 Item", description: "Item belongs to m3", unit_price: 30000)
    @m4_item = @merch_4.items.create!(name: "Merch 4 Item", description: "Item belongs to m4", unit_price: 40000)
    @m5_item = @merch_5.items.create!(name: "Merch 5 Item", description: "Item belongs to m5", unit_price: 50000)
    @m6_item = @merch_6.items.create!(name: "Merch 6 Item", description: "Item belongs to m6", unit_price: 60000)

    @test_custy = Customer.create!(first_name: "Test", last_name: "Custy")

    @m2_inv = @test_custy.invoices.create!(status: 1)
    @m3_inv = @test_custy.invoices.create!(status: 1)
    @m4_inv = @test_custy.invoices.create!(status: 1)
    @m5_inv = @test_custy.invoices.create!(status: 1)
    @m6_inv = @test_custy.invoices.create!(status: 1)

    @m2_ii = InvoiceItem.create!(item_id: @m2_item.id, invoice_id: @m2_inv.id, quantity: 1, unit_price: @m2_item.unit_price, status: 2)
    @m3_ii = InvoiceItem.create!(item_id: @m3_item.id, invoice_id: @m3_inv.id, quantity: 4, unit_price: @m3_item.unit_price, status: 2)
    @m4_ii = InvoiceItem.create!(item_id: @m4_item.id, invoice_id: @m4_inv.id, quantity: 1, unit_price: @m4_item.unit_price, status: 2)
    @m5_ii = InvoiceItem.create!(item_id: @m5_item.id, invoice_id: @m5_inv.id, quantity: 3, unit_price: @m5_item.unit_price, status: 2)
    @m6_ii = InvoiceItem.create!(item_id: @m6_item.id, invoice_id: @m6_inv.id, quantity: 10, unit_price: @m6_item.unit_price, status: 2)

    @m2_tr = @m2_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @m3_tr = @m3_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @m4_tr = @m4_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @m5_tr = @m5_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @m6_tr = @m6_inv.transactions.create!(credit_card_number: 4039485738495837, result: "success")

    visit '/admin/invoices'
  end

  it 'displays all invoices' do
    expect(page).to have_content("Invoice ##{@m2_inv.id}")
    expect(page).to have_content("Invoice ##{@m3_inv.id}")
    expect(page).to have_content("Invoice ##{@m4_inv.id}")
    expect(page).to have_content("Invoice ##{@m5_inv.id}")
    expect(page).to have_content("Invoice ##{@m6_inv.id}")
  end
end
