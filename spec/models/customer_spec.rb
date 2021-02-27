require "rails_helper"

describe Customer do
	before :each do
		@mer_1 = create(:merchant)
		@cust_1 = create(:customer, first_name: "A", last_name: "1")
		@cust_2 = create(:customer, first_name: "B", last_name: "1")
		@cust_3 = create(:customer, first_name: "C", last_name: "1")
		@cust_4 = create(:customer, first_name: "D", last_name: "1")
		@cust_5 = create(:customer, first_name: "E", last_name: "1")
		@cust_6 = create(:customer, first_name: "F", last_name: "1")
		@cust_7 = create(:customer, first_name: "G", last_name: "1")
		@cust_8 = create(:customer, first_name: "H", last_name: "1")
		@cust_9 = create(:customer, first_name: "I", last_name: "1")
		@cust_10 = create(:customer, first_name: "J", last_name: "1")
		@item_1 = create(:item, merchant_id: @mer_1.id)
		@item_2 = create(:item, merchant_id: @mer_1.id)
		@item_3 = create(:item, merchant_id: @mer_1.id)
		@item_4 = create(:item, merchant_id: @mer_1.id)
		@item_5 = create(:item, merchant_id: @mer_1.id)
		@item_6 = create(:item, merchant_id: @mer_1.id)
		@invoice1 = create(:invoice, customer_id: @cust_1.id)
		@invoice2 = create(:invoice, customer_id: @cust_2.id)
		@invoice3 = create(:invoice, customer_id: @cust_3.id)
		@invoice4 = create(:invoice, customer_id: @cust_4.id)
		@invoice5 = create(:invoice, customer_id: @cust_5.id)
		@invoice6 = create(:invoice, customer_id: @cust_6.id)
		@invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id)
		@invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice2.id)
		@invoice_item3 = create(:invoice_item, item_id:@item_3.id, invoice_id:@invoice3.id)
		@invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice4.id)
		@invoice_item5 = create(:invoice_item, item_id:@item_5.id, invoice_id:@invoice6.id)
		@invoice_item6 = create(:invoice_item, item_id:@item_6.id, invoice_id:@invoice6.id)
		@transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "failed", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction3 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
		@transaction5 = create(:transaction, result: "success", invoice_id: @invoice5.id)
		@transaction6 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction7 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction8 = create(:transaction, result: "success", invoice_id: @invoice6.id)
	end
  describe "relationships" do
    it { should have_many :invoices }
  end

  describe "class methods" do 
  	it"::top_customers"do
  		expect(Customer.top_customers.length).to eq(5)
  		expect(Customer.top_customers.first.count_of_success).to eq(2)
  		expect(Customer.top_customers.first.first_name).to eq("A")

  	end
  end

end
