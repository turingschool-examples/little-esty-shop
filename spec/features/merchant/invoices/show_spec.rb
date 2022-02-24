require 'rails_helper'

RSpec.describe "Merchant Invoice Show Page" do
  before(:each) do
     @merchant = Merchant.create!(name: 'Chuckin Pucks')
     @merchant2 = Merchant.create!(name: 'Baby Beanies')
     @customer = Customer.create!(first_name: 'Samantha', last_name: 'Ore')
     @customer_2 = Customer.create!(first_name: 'Jake', last_name: 'Statefarm')

     @invoice = Invoice.create!(customer_id: @customer.id, status: 2)
     @invoice2 = Invoice.create!(customer_id: @customer.id, status: 2)
     @invoice3 = Invoice.create!(customer_id: @customer_2.id, status: 2)


     @item_1 = Item.create!(name: "Shampoo", description: "Cleans the lettuce", unit_price: 5, merchant_id: @merchant.id)
     @item_2 = Item.create!(name: "Beans", description: "The musical", unit_price: 3, merchant_id: @merchant.id)
     @item_3 = Item.create!(name: "Harry the Hat", description: "Super warm", unit_price: 4, merchant_id: @merchant2.id)

     @ii_1 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
     @ii_2 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_2.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")

     @ii_3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item_3.id, quantity: 12, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")

     @transaction1 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice2.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice3.id)
  end


  it "shows an invoice from a merchant" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %-d, %Y"))

    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)

    expect(page).to_not have_content(@customer_2.first_name)
    expect(page).to_not have_content(@customer_2.last_name)
  end

  it "shows items from an invoice" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@ii_1.quantity)
    expect(page).to have_content(@item_1.unit_price)

    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@ii_2.quantity)
    expect(page).to have_content(@item_2.unit_price)

    expect(page).to have_content(@ii_1.status)
    expect(page).to have_content(@ii_2.status)

    expect(page).to_not have_content(@item_3.name)
  end

  it "displays total revenue that will be generated from all items on invoice" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

    expect(page).to have_content(@invoice.total_revenue)
  end

  it "should have select field to update item status" do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    save_and_open_page
    expect(page).to have_button("Update Item Status")
    select "packaged", :from => "status", match: :first
    click_on("Update Item Status", match: :first)
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")

    within("#item-status", match: :first) do
      expect(page).to have_content(@ii_1.status)
    end
  end
end
