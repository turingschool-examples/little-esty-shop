require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: "Johns Tools")
    @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
    @merchant_3 = Merchant.create!(name: "Pretty Plumbing")

    @customer_1 = Customer.create!(first_name: "Larry", last_name: "Smith") 
    @customer_2 = Customer.create!(first_name: "Susan", last_name: "Field") 
    @customer_3 = Customer.create!(first_name: "Barry", last_name: "Roger") 
    @customer_4 = Customer.create!(first_name: "Mary", last_name: "Flower") 
    @customer_5 = Customer.create!(first_name: "Tim", last_name: "Colin") 
    @customer_6 = Customer.create!(first_name: "Harry", last_name: "Dodd") 
    @customer_7 = Customer.create!(first_name: "Molly", last_name: "McMann")
    @customer_8 = Customer.create!(first_name: "Gary", last_name: "Jone") 

    @invoice_1 = @customer_1.invoices.create!(status: :completed) 
    @invoice_2 = @customer_2.invoices.create!(status: :completed) 
    @invoice_3 = @customer_3.invoices.create!(status: :completed) 
    @invoice_4 = @customer_4.invoices.create!(status: :completed) 
    @invoice_5 = @customer_5.invoices.create!(status: :completed) 
    @invoice_6 = @customer_6.invoices.create!(status: :completed) 
    @invoice_7 = @customer_7.invoices.create!(status: :completed) 
    @invoice_8 = @customer_8.invoices.create!(status: :completed) 

    @item_1 = @merchant_1.items.create!(name: "Mega Tool Box", description: "Huge Toolbox with lots of options") 
    @item_2 = @merchant_2.items.create!(name: "Blue Hammock", description: "Large blue hammock for all your outdoor adventures")
    @item_3 = @merchant_3.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.")

    @invoice_item1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 2000, status: :packaged)
    @invoice_item2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1000, status: :pending)
    @invoice_item3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 4, unit_price: 1000, status: :shipped)
    @invoice_item4 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 2500, status: :pending)
    @invoice_item5 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 3, unit_price: 2500, status: :shipped)
    @invoice_item6 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 3, unit_price: 2500, status: :packaged)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :failed)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :failed)
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :failed)
    @transaction_4 = @invoice_1.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success)
    @transaction_5 = @invoice_1.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success)
    @transaction_6 = @invoice_1.transactions.create!(credit_card_number: "5562017483947471", credit_card_expiration_date: "", result: :success)
    @transaction_7 = @invoice_1.transactions.create!(credit_card_number: "5478972046869861", credit_card_expiration_date: "", result: :success)
    @transaction_8 = @invoice_1.transactions.create!(credit_card_number: "4333324752400785", credit_card_expiration_date: "", result: :success)

    # customer_2 transactions
    @transaction_9 = @invoice_2.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :failed)
    @transaction_10 = @invoice_2.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success) 
    @transaction_11 = @invoice_2.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :success) 
    @transaction_12 = @invoice_2.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success) 
    @transaction_13 = @invoice_2.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success) 
    @transaction_14 = @invoice_2.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: :success) 
    @transaction_15 = @invoice_2.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: :success) 
    @transaction_16 = @invoice_2.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: :success) 
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  it '#unshipped_invoices' do
    expect(Invoice.unshipped_invoices).to eq([@invoice_1, @invoice_2, @invoice_4, @invoice_5])
  end

  it '#successful_transactions' do
      expect(Invoice.successful_transactions).to eq(12)
    end
end