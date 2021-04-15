require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    # @merchant = Merchant.create!(name: 'Ice Cream Parlour')
    @merchant = create(:merchant)
    # @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    # @item_2 = @merchant.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
    @item_1, @item_2 = create_list(:item, 2, merchant: @merchant)
    # @item_2 = create(:item, merchant: @merchant)
    @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
    @customer_1 = Customer.create!(first_name: 'Little', last_name: 'Stauart')
    @customer_2 = Customer.create!(first_name: 'Racoon', last_name: 'Stauart')
    @customer_3 = Customer.create!(first_name: 'Lil', last_name: 'Stauart')
    @customer_4 = Customer.create!(first_name: 'Weee', last_name: 'Stauart')
    @customer_5 = Customer.create!(first_name: 'Massive', last_name: 'Stauart')
    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_2 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_2.id}")
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_3.id}")
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_4.id}")
    @invoice_6 = Invoice.create!(status: 0, customer_id: "#{@customer_5.id}")
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 40, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 20, status: 2)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 10, unit_price: 20, status: 2)
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")
    visit "/merchant/#{@merchant.id}/dashboard"
  end

  it "can see merchant name" do
    expect(page).to have_content(@merchant.name)
  end

  it "see links to merchant items index and merchant invoices index" do
    expect(page).to have_link('My Items')
    expect(page).to have_link('My Invoices')
  end

  it 'shows top five favorite customers who have the most successful transactions' do
    expect(page).to have_content("Top 5 Customers")
    save_and_open_page
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
