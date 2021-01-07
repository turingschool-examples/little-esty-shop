require "rails_helper"

describe Customer, type: :model do
  describe "relations" do
    it { should have_many :invoices }
    it { should have_many :transactions}
  end

  describe "class methods" do 
    it "top_customers" do 
      customers = []
      10.times { customers << create(:customer) }
      customers.each do |customer|
        create(:invoice, customer_id:customer.id)
      end
      first_customer = customers[0].invoices[0].id
      second_customer = customers[1].invoices[0].id
      third_customer = customers[2].invoices[0].id
      fourth_customer = customers[3].invoices[0].id
      fifth_customer = customers[4].invoices[0].id
      sixth_customer = customers[5].invoices[0].id
      seventh_customer = customers[6].invoices[0].id
      
      10.times { create(:transaction, invoice_id:first_customer, result: "success")}
      9.times { create(:transaction, invoice_id:second_customer, result: "success")}
      8.times { create(:transaction, invoice_id:third_customer, result: "success")}
      7.times { create(:transaction, invoice_id:fourth_customer, result: "success")}
      6.times { create(:transaction, invoice_id:fifth_customer, result: "success")}
      5.times { create(:transaction, invoice_id:sixth_customer, result: "success")}
      13.times { create(:transaction, invoice_id:seventh_customer, result: "failed")}

      expect(Customer.top_customers(5).to_a).to eq(customers[0..4])
    end
  end

  describe "instance methods" do 
    it "number_of_successful_transactions" do 
      customers = []
      10.times { customers << create(:customer) }
      customers.each do |customer|
        create(:invoice, customer_id:customer.id)
      end
      first_customer = customers[0].invoices[0].id
      second_customer = customers[1].invoices[0].id
      third_customer = customers[2].invoices[0].id
      fourth_customer = customers[3].invoices[0].id
      fifth_customer = customers[4].invoices[0].id
      sixth_customer = customers[5].invoices[0].id
      seventh_customer = customers[6].invoices[0].id
      
      10.times { create(:transaction, invoice_id:first_customer, result: "success")}
      9.times { create(:transaction, invoice_id:second_customer, result: "success")}
      8.times { create(:transaction, invoice_id:third_customer, result: "success")}
      7.times { create(:transaction, invoice_id:fourth_customer, result: "success")}
      6.times { create(:transaction, invoice_id:fifth_customer, result: "success")}
      5.times { create(:transaction, invoice_id:sixth_customer, result: "success")}
      13.times { create(:transaction, invoice_id:seventh_customer, result: "failed")}

      expect(customers[0].number_of_successful_transactions).to eq(10)
      expect(customers[1].number_of_successful_transactions).to eq(9)
      expect(customers[2].number_of_successful_transactions).to eq(8)
      expect(customers[3].number_of_successful_transactions).to eq(7)
      expect(customers[4].number_of_successful_transactions).to eq(6)
      expect(customers[5].number_of_successful_transactions).to eq(5)
      expect(customers[6].number_of_successful_transactions).to eq(0)
    end
  end
end
