require "rails_helper"

describe Customer do
	before :each do
		@mer_1 = create(:merchant)
		@customers = create_list(:customer, 10)
		@items = create_list(:item, 6, merchant_id: @mer_1.id )

		invoices = @customers.map do |customer|
			create(:invoice,customer_id: customer.id)
		end

		invoice_items = invoices.map do |invoice|
			@items.map do |item|
				create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
			end
		end

		results = ["success", "failed"]
		transactions = invoices.map do |invoice|
			create(:transaction, result: "#{results.sample}", invoice_id: invoice.id)
		end
	end
  describe "relationships" do
    it { should have_many :invoices }
  end

  describe "class methods" do 
  	it"::top_customers"do
  		expect(Customer.top_customers.length).to eq(5)
  		expect(Customer.top_customers.first.count_of_success).to eq(2)
  		expect(Customer.top_customers.first.first_name).to eq("Chia Reichel V")
  		expect(Customer.top_customers.first.last_name).to eq("Cathern Barton")
  	end
  end

end
