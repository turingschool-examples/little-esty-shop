require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour',status: 0)
    @tattoo = Merchant.create!(name: 'Tattoo Shop', status: 0)
    @scoop = @parlour.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @cone = @parlour.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
    @ink = @tattoo.items.create!(name: 'Dark Matter', description: 'black ink for tattoos', unit_price: 6)
    @paper = @tattoo.items.create!(name: 'Paper Towels', description: 'wipes ink off', unit_price: 2)
    @harry = Customer.create!(first_name: 'Harry', last_name: 'Potter')
    @ron = Customer.create!(first_name: 'Ron', last_name: 'Weasley')
    @hermione = Customer.create!(first_name: 'Hermione', last_name: 'Granger')
    @neville = Customer.create!(first_name: 'Neville', last_name: 'Longbottom')
    @lord = Customer.create!(first_name: 'Lord', last_name: 'Voldemort')
    @snape = Customer.create!(first_name: 'Severus', last_name: 'Snape')
    @invoice1 = Invoice.create!(status: 0, customer_id: "#{@harry.id}")
    @invoice2 = Invoice.create!(status: 0, customer_id: "#{@ron.id}")
    @invoice3 = Invoice.create!(status: 0, customer_id: "#{@hermione.id}")
    @invoice4 = Invoice.create!(status: 0, customer_id: "#{@neville.id}")
    @invoice5 = Invoice.create!(status: 0, customer_id: "#{@lord.id}")
    @invoice6 = Invoice.create!(status: 0, customer_id: "#{@snape.id}")
    InvoiceItem.create!(item_id: @cone.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 40, status: 0)
    InvoiceItem.create!(item_id: @cone.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @ink.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @paper.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @scoop.id, invoice_id: @invoice5.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @ink.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20, status: 2)
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice1.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice1.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice3.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice4.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice2.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice2.id}")

    visit "/admin"
  end

  it "shows header for admin dashboard" do
    expect(page).to have_content("Admin Dashboard")
  end

  it "see links to admin merchants index and admin invoices index" do
    expect(page).to have_link("Merchants")
    expect(page).to have_link("Invoices")
  end

  it "shows top customers in the admin dashboard" do
    expect(page).to have_content("Top Customers")
      within("#customer-#{@harry.id}") do
        expect(page).to have_content(@harry.first_name)
        expect(page).to have_content(@harry.last_name)
    end
  end


  it "shows incomplete invoices" do
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_link("Invoice #{@invoice1.id}")

    within("#invoice-#{@invoice1.id}") do
    expect(page).to have_content("Invoice #{@invoice1.id} - #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
    end
  end
end
