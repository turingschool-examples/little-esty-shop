require 'rails_helper'

RSpec.describe Merchant, type: :model do

  before(:each) do
    @merch_1 = Merchant.create!(name: "Shop Here")
    @merch_2 = Merchant.create!(name: "Handmade by Hannah", status: 1)
    @merch_3 = Merchant.create!(name: "Curiosities", status: 1)

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
  
  describe "relationships" do
    it {should have_many(:items) }
    it {should have_many(:invoice_items).through(:items) }
    it {should have_many(:invoices).through(:invoice_items) }
    it {should have_many(:customers).through(:invoices) }
  end
  
  describe "methods" do 
    
    #refactor opportunity for later
    xit "#merchants_invoices - returns all of a merchant's invoices" do 
      expect(@merch_1.merchants_invoices).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5])
    end

    it "#items_ready_to_ship" do 
      expect(@merch_1.items_ready_to_ship).to contain_exactly(@invoice_item_1, @invoice_item_2)
    end
    
    it "#favorite_customers - returns top 5 customers with most successful transactions" do
      expect(@merch_1.merchants_favorite_customers).to contain_exactly(@cust_2, @cust_3, @cust_4, @cust_5, @cust_6)
    end

    it ".enabled_merchants" do 
      expect(Merchant.enabled_merchants).to eq([@merch_2, @merch_3])
    end

    it ".disabled_merchants" do 
      expect(Merchant.disabled_merchants).to eq([@merch_1])
    end
  end
  

end
