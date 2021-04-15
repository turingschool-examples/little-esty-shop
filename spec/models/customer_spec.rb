require "rails_helper"

RSpec.describe Customer do
  describe "relationships" do
    it {should have_many :invoices}
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'class methods' do
    describe '#top_five' do
      it 'returns the top five customers with the most successful transactions' do
        
        customer5 = Customer.create!(first_name: "Eff", last_name: "Erk")
        invoice5 = customer5.invoices.create!(status: 1)
        transaction11 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)

        customer1 = Customer.create!(first_name: "Ayy", last_name: "All")
        invoice1 = customer1.invoices.create!(status: 0)
        transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
        
        customer3 = Customer.create!(first_name: "Cee", last_name: "Cold")
        invoice3 = customer3.invoices.create!(status: 2)
        transaction6 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction7 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction8 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        
        customer2 = Customer.create!(first_name: "Bee", last_name: "Bold")
        invoice2 = customer2.invoices.create!(status: 1)
        transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction3 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction4 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction5 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        
        customer6 = Customer.create!(first_name: "Gee", last_name: "Golly")
        invoice6 = customer6.invoices.create!(status: 2)
        transaction12 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
        transaction13 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        
        customer4 = Customer.create!(first_name: "Dee", last_name: "Droll")
        invoice4 = customer4.invoices.create!(status: 0)
        transaction9 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        transaction10 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)

        expect(Customer.top_five).to eq([customer2, customer3, customer4, customer5, customer6])
      end
    end
  end 
end