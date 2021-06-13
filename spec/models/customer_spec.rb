require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
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

    @item4 = @merchant1.items.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.0, status: 0)
    @item5 = @merchant1.items.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.5, status: 0)
    @item6 = @merchant1.items.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.0, status: 0)
    @item7 = @merchant1.items.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 11.5, status: 0)
    @item8 = @merchant1.items.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.0, status: 0)
    @item9 = @merchant1.items.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.0, status: 0)
    @item_0 = @merchant1.items.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.0, status: 0)

    @invoice_item0 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice1) #96.0  1
    @invoice_item6 = @item9.invoice_items.create!(quantity: 5, unit_price: 17.0, status: 2, invoice: @invoice3) #85.0  1
    @invoice_item3 = @item6.invoice_items.create!(quantity: 7, unit_price: 10.0, status: 2, invoice: @invoice2) #70.0  2
    @invoice_item1 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice6) #48.5  3
    @invoice_item2 = @item5.invoice_items.create!(quantity: 3, unit_price: 15.5, status: 2, invoice: @invoice5) #46.5  4
    @invoice_item4 = @item7.invoice_items.create!(quantity: 4, unit_price: 11.5, status: 2, invoice: @invoice4)

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
      it 'can show the top five customers for a merchant' do
        expect(Customer.top_customers(@merchant1.id)).to eq([@customer6, @customer2, @customer1, @customer5, @customer3])
      end

      it 'can give the amount of successful transactions each customer had with their merchant' do
        expect(@customer1.top_successful_transactions).to eq(3)
      end
    end
  end
end
