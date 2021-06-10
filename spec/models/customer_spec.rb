require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:merchants_customers) }
    it { should have_many(:merchants).through(:merchants_customers) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  before :each do
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")
    @customer2 = Customer.create!(first_name: "Lil", last_name: "Boosie")
    @customer3 = Customer.create!(first_name: "Snoop", last_name: "Dizzy")
    @customer4 = Customer.create!(first_name: "Michael", last_name: "Jordan")
    @customer5 = Customer.create!(first_name: "Lebron", last_name: "James")
    @customer6 = Customer.create!(first_name: "Mike", last_name: "Vick")
    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)
    @invoice6 = @customer6.invoices.create!(status: 2)

    @merchcust1 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer1.id)
    @merchcust2 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer2.id)
    @merchcust3 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer3.id)
    @merchcust4 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer4.id)
    @merchcust5 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer5.id)
    @merchcust6 = MerchantsCustomer.create!(merchant_id: @merchant1.id, customer_id: @customer6.id)

    # customer 1 - third
    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    # customer 2 - second
    @transaction4 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735607)
    # customer 3 - fifth
    @transaction8 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    # customer 4 - sixth
    @transaction9 = @invoice4.transactions.create!(result: 0, credit_card_number: 4203696133194408)
    @transaction10 = @invoice4.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    # customer 5 - fourth
    @transaction11 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    # customer 6 - first
    @transaction13 = @invoice6.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction14 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction16 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction17 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
  end

  describe 'class methods' do
    describe '.top_5_customers' do
      it "show the top 5 customers by successful transactions" do
        expect(Customer.top_5_customers).to eq([@customer6, @customer2, @customer1, @customer5, @customer3])

        expect(Customer.top_5_customers).to_not eq([@customer6, @customer2, @customer1, @customer5, @customer4])
      end
    end
  end

  describe 'instance methods' do
    describe '#number_of_successful_transactions' do
      it "shows number of successful transactions for each customer" do
        expect(@customer6.number_of_successful_transactions).to eq(5)
        expect(@customer4.number_of_successful_transactions).to eq(0)

        expect(@customer2.number_of_successful_transactions).to_not eq(2)
      end
    end

    describe 'merchants top customers' do
      it 'can show the top five customers' do
        expect(Customer.top_customers(@merchant1.id)).to eq([@customer6, @customer2, @customer1, @customer5, @customer3])
      end

      it 'can give the amount of successful transactions each customer had with their merchant' do
        expect(@customer1.top_successful_transactions(@merchant1.id)).to eq(3)
        expect(@customer4.top_successful_transactions(@merchant1.id)).to eq(0)
      end
    end
  end
end
