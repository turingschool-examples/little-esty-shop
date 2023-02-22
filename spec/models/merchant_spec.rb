require 'rails_helper'

RSpec.describe Merchant, type: :model do
	before(:each) do
		@merchant = Merchant.create!(name: "Carlos Jenkins") 
		@cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
		@cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
		@cust3 = Customer.create!(first_name: "John", last_name: "Fiel")
		@cust4 = Customer.create!(first_name: "Tim", last_name: "Fiel")
		@cust5 = Customer.create!(first_name: "Linda", last_name: "Fiel")
		@cust6 = Customer.create!(first_name: "Lucy", last_name: "Fiel")
		@inv1 = @cust1.invoices.create!(status: 1)
		@inv2 = @cust2.invoices.create!(status: 1)
		@inv3 = @cust3.invoices.create!(status: 1)
		@inv4 = @cust4.invoices.create!(status: 1)
		@inv5 = @cust6.invoices.create!(status: 1)
		@bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 
		@trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans3 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans4 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans5 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv3.id)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv4.id)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv5.id)
	end
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "#top_five_customers" do
    it "returns the top five customers and their total number of transactions" do
      expect(@merchant.top_five_customers).to eq([@cust1, @cust2, @cust3, @cust4, @cust6])
      expect(@merchant.top_five_customers).to_not contain(@cust5)
    end
  end
end
