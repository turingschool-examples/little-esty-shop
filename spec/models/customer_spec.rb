require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "class methods" do
    it "tracks a merchant's favorite customers" do
      customer1 = Customer.create!(first_name: 'Zach', last_name: 'Hazelwood')
      customer2 = Customer.create!(first_name: 'Rue', last_name: 'Zheng')
      customer3 = Customer.create!(first_name: 'Eric', last_name: 'Espindola')
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer2.id, status: 2)
      invoice5 = Invoice.create!(customer_id: customer2.id, status: 2)
      invoice6 = Invoice.create!(customer_id: customer3.id, status: 2)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: true, created_at: "2012-03-27 14:54:09 UTC")
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: true, created_at: "2012-03-27 14:54:09 UTC")
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: true, created_at: "2012-03-27 14:54:10 UTC")

      all_favorite_customers = Customer.favorite_customers(3)
# require "pry"; binding.pry
      expect(all_favorite_customers.first.first_name).to eq('Zach')
      expect(all_favorite_customers.first.last_name).to eq('Hazelwood')
      expect(all_favorite_customers.first.count).to eq(3)
      expect(all_favorite_customers.second.first_name).to eq('Rue')
      expect(all_favorite_customers.second.last_name).to eq('Zheng')
      expect(all_favorite_customers.second.count).to eq(2)
      expect(all_favorite_customers.last.first_name).to eq('Eric')
      expect(all_favorite_customers.last.last_name).to eq('Espindola')
      expect(all_favorite_customers.last.count).to eq(1)
    end

    it "counts the number of a customer's successful transactions" do
      customer1 = Customer.create!(first_name: 'Zach', last_name: 'Hazelwood')
      customer2 = Customer.create!(first_name: 'Rue', last_name: 'Zheng')
      customer3 = Customer.create!(first_name: 'Eric', last_name: 'Espindola')
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer2.id, status: 2)
      invoice5 = Invoice.create!(customer_id: customer2.id, status: 2)
      invoice6 = Invoice.create!(customer_id: customer3.id, status: 2)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: true, created_at: "2012-03-27 14:54:09 UTC")
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: true, created_at: "2012-03-27 14:54:09 UTC")
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: true, created_at: "2012-03-27 14:54:10 UTC")
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: true, created_at: "2012-03-27 14:54:10 UTC")

      expect(Customer.count_successful_transactions(customer1.id)).to eq(3)
      expect(Customer.count_successful_transactions(customer2.id)).to eq(2)
      expect(Customer.count_successful_transactions(customer3.id)).to eq(1)
    end
  end
end
