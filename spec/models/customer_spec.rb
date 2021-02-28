require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  before :each do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")
    @customer7 = Customer.create!(first_name: "Molly", last_name: "Rae")

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
    @invoice2 = Invoice.create!(customer_id: @customer2.id, status: "in progress")
    @invoice3 = Invoice.create!(customer_id: @customer3.id, status: "completed")
    @invoice4 = Invoice.create!(customer_id: @customer4.id, status: "cancelled")
    @invoice5 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice6 = Invoice.create!(customer_id: @customer6.id, status: "completed")
    @invoice7 = Invoice.create!(customer_id: @customer7.id, status: "completed")

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction2 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction3 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction4 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction5 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction6 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction7 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction8 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction9 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction10 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction11 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction12 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction13 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction14 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction15 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction16 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction17 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction18 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction19 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction20 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction21 = Transaction.create!(invoice_id: @invoice6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction22 = Transaction.create!(invoice_id: @invoice7.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end
  describe "class methods" do
    describe "top_five_customers" do
      it "Lists top five customers in desc" do

        expected = [@customer1, @customer2, @customer3, @customer4, @customer5]

        expect(Customer.top_five_customers).to eq(expected)
      end
    end
  end
  describe "instance methods" do
     describe "name" do
      it "prints first and last name as one name" do

        expect(@customer1.name).to eq("Bob Gu")
      end
    end
    describe "successful_count" do
      it "prints count of all successful transactions by unique customer" do

        expect(@customer1.successful_count).to eq(6)
      end
    end
  end
end
