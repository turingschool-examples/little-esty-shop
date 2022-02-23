require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end


  describe ".top_5_customers" do
    before(:each) do

       @merchant1 = Merchant.create!(name: 'Chuckin Pucks')
       @customer = Customer.create!(first_name: 'Samantha', last_name: 'Ore')
       @customer_2 = Customer.create!(first_name: 'Jake', last_name: 'Statefarm')
       @customer_3 = Customer.create!(first_name: 'Harry', last_name: 'Potter')
       @customer_4 = Customer.create!(first_name: 'Lloyd', last_name: 'Christmas')
       @customer_5 = Customer.create!(first_name: 'Fettucine', last_name: 'Alfredo')
       @customer_6 = Customer.create!(first_name: 'Bob', last_name: 'Builder')
       @invoice_1 = Invoice.create!(customer_id: @customer.id, status: 2)
       @invoice_1a = Invoice.create!(customer_id: @customer.id, status: 2)
       @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2)
       @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 2)
       @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 2)
       @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 2)
       @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 2)

       @item_1 = Item.create!(name: "Shampoo", description: "Cleans the lettuce", unit_price: 5, merchant_id: @merchant1.id)

       @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
       @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1a.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
       @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
       @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
       @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
       @ii_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
       @ii_7 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
       @ii_8 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")

       @transaction1 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_1.id)
       @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_1a.id)
       @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_2.id)
       @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_3.id)
       @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_4.id)
       @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_5.id)
    end


    it "displays top 5 customers that conducted largest number of successful transactions with a merchant" do

      expect(Customer.top_5_customers).to eq([@customer,@customer_2,@customer_3,@customer_4,@customer_5])
    end

    it "exists" do
      customer = create(:customer)
      expect(customer).to be_a(Customer)
      expect(customer).to be_valid
    end

  end
end
