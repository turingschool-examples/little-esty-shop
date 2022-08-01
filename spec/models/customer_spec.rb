require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }

  end

  before :each do
    # @customer_1 = Customer.create!( first_name: "Blake",
                                    # last_name: "Saylor")
  end

  describe 'class methods' do
    it 'top_5_by_transaction lists top 5 customers by successful transaction' do
      8.times do
          Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
      end
      Customer.all.each.with_index do |customer, index|
          index.times do 
              customer.invoices.create!(status: Faker::Number.between(from: 0, to: 2) )
          end
      end
      Invoice.all.each do |invoice|
          invoice.transactions.create!(result: "success", credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
      end
      20.times do
          Transaction.create!(result: "failed",invoice_id: Faker::Number.between(from: Invoice.first.id, to: Invoice.last.id), credit_card_number: Faker::Business.credit_card_number, credit_card_expiration_date: Faker::Business.credit_card_expiry_date)
      end

      customers = Customer.top_5_by_transaction

      expect(customers.first).to eq(Customer.all.last)
      expect(customers.last).to eq(Customer.all.fourth)
      expect(customers).to_not including(Customer.all.first)
      end
  end

  describe 'instance methods' do

  end
end
