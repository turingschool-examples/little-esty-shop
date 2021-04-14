require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant = Merchant.create!(name: 'Ice Cream Parlour')
    @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @merchant.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
    @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_2 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 40, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 2)
    # @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice.id}")
    visit "/merchant/#{@merchant.id}/dashboard"
  end

  it "can see merchant name" do
    expect(page).to have_content(@merchant.name)
  end

  it "see links to merchant items index and merchant invoices index" do
    expect(page).to have_link('My Items')
    expect(page).to have_link('My Invoices')
  end

  it "shows items ready to ship" do
    expect(page).to have_content("Items Ready to Ship")
    within("#item-#{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      #need to finish user story tests
    end
  end
end
