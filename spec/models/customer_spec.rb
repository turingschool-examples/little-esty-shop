require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe "relationships" do 
    it {should have_many(:invoices) }
    it {should have_many(:transactions).through(:invoices) }
    it {should have_many(:invoice_items).through(:invoices) }
    it {should have_many(:items).through(:invoice_items) }
    it {should have_many(:merchants).through(:items) }
  end

  before(:each) do 
    @merch_1 = Merchant.create!(name: "Shop Here")

    @item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{@merch_1.id}")

    @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")
    @cust_2 = Customer.create!(first_name:"Kimmy", last_name:"Gibbler")
    @cust_3 = Customer.create!(first_name:"Bob", last_name:"Sagget")
    @cust_4 = Customer.create!(first_name:"Uncle", last_name:"Dave")
    @cust_5 = Customer.create!(first_name:"Uncle", last_name:"Jessie")
    @cust_6 = Customer.create!(first_name:"DJ", last_name:"Tanner")

    @invoice_1 = Invoice.create!(customer_id:"#{@cust_2.id}", status:1)
    @invoice_2 = Invoice.create!(customer_id:"#{@cust_3.id}", status:1)
    @invoice_3 = Invoice.create!(customer_id:"#{@cust_4.id}", status:1)
    @invoice_4 = Invoice.create!(customer_id:"#{@cust_5.id}", status:1)
    @invoice_5 = Invoice.create!(customer_id:"#{@cust_6.id}", status:1)

    @transaction_1 = Transaction.create(invoice_id:"#{@invoice_1.id}", result: "success")
    @transaction_2 = Transaction.create(invoice_id:"#{@invoice_2.id}", result: "success")
    @transaction_3 = Transaction.create(invoice_id:"#{@invoice_3.id}", result: "success")
    @transaction_4 = Transaction.create(invoice_id:"#{@invoice_4.id}", result: "success")
    @transaction_5 = Transaction.create(invoice_id:"#{@invoice_5.id}", result: "success")
    
    @invoice_item_1 = InvoiceItem.create!(invoice_id:"#{@invoice_1.id}", item_id:"#{@item_1.id}", status: 1, quantity:1, unit_price:600)
    @invoice_item_2 = InvoiceItem.create!(invoice_id:"#{@invoice_2.id}", item_id:"#{@item_1.id}", status: 1, quantity:1, unit_price:600)
    @invoice_item_3 = InvoiceItem.create!(invoice_id:"#{@invoice_3.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_4 = InvoiceItem.create!(invoice_id:"#{@invoice_4.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_5 = InvoiceItem.create!(invoice_id:"#{@invoice_5.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
  end

  describe "methods" do 

    it ".favorite_customers" do
      expect(Customer.favorite_customers).to contain_exactly(@cust_2, @cust_3, @cust_4, @cust_5, @cust_6) 
    end
  end
  
end
