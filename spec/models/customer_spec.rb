require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:invoices)}
  end

  describe 'class methods' do
    let!(:customer1) { Customer.create!(first_name: "Britney", last_name: "Spears")}
    let!(:customer2) { Customer.create!(first_name: "Bob", last_name: "Smith")}
    let!(:customer3) { Customer.create!(first_name: "Bill", last_name: "Johnson")}
    let!(:customer4) { Customer.create!(first_name: "Boris", last_name: "Nelson")}
    let!(:customer5) { Customer.create!(first_name: "Barbara", last_name: "Hilton")}
    let!(:customer6) { Customer.create!(first_name: "Bella", last_name: "Thomas")}

    let!(:invoice1) { customer1.invoices.create!(status: 2) }
    let!(:invoice2) { customer1.invoices.create!(status: 2) }

    let!(:invoice3) { customer2.invoices.create!(status: 2) }
    let!(:invoice4) { customer2.invoices.create!(status: 2) }

    let!(:invoice5) { customer3.invoices.create!(status: 2) }
    let!(:invoice6) { customer3.invoices.create!(status: 2) }

    let!(:invoice7) { customer4.invoices.create!(status: 2) }

    let!(:invoice8) { customer5.invoices.create!(status: 2) }
    let!(:invoice9) { customer5.invoices.create!(status: 2) }
    
    let!(:invoice10) { customer6.invoices.create!(status: 2) }
    let!(:invoice11) { customer6.invoices.create!(status: 2) }
    
    let!(:transaction1) { invoice1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction2) { invoice1.transactions.create!(credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction3) { invoice2.transactions.create!(credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction4) { invoice2.transactions.create!(credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction5) { invoice2.transactions.create!(credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction6) { invoice3.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction7) { invoice3.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
    
    let!(:transaction8) { invoice4.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
    
    let!(:transaction9) { invoice5.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction10) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction11) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction12) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction13) { invoice7.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }

    let!(:transaction14) { invoice8.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction15) { invoice8.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction16) { invoice9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction17) { invoice10.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction18) { invoice11.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
    let!(:transaction19) { invoice11.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }

    
    describe '::top_five_customers' do
      it 'returns a list of the 5 customers with the largest number of successful transactions' do
        expect(Customer.top_five_customers).to eq([customer1, customer3, customer5, customer6, customer2])
        
        invoice12 = customer4.invoices.create!(status: 2)
        invoice13 = customer4.invoices.create!(status: 2)

        transaction20 = invoice12.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
        transaction21 = invoice13.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

        expect(Customer.top_five_customers).to eq([customer1, customer3, customer5, customer4, customer6])
      end
    end
  end
end
