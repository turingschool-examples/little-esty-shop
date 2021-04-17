require 'rails_helper'

RSpec.describe "Merchant Invoices Index" do
  before(:each) do
    @merchant = Merchant.create!(name: 'Ice Cream Parlour')
    @merchant_1 = Merchant.create!(name: 'Taco Tuesday')
    @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @merchant.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
    @item_3 = @merchant_1.items.create!(name: 'Taco Shells', description: 'holds taco fillings', unit_price: 3)
    @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
    @customer_1 = Customer.create!(first_name: 'Little', last_name: 'Stauart')
    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_2 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 40, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 20, status: 2)
    @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
    @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
    @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
    visit "/merchant/#{@merchant.id}/invoices"
  end

  it 'can see all invoices ids that include at least one of merchants items' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).not_to have_content(@invoice_3.id)
  end

  it 'invoice id can link to invoice show page' do
    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_2.id}")
    expect(page).not_to have_link("#{@invoice_3.id}")
  end

end
