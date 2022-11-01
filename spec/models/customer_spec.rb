require 'rails_helper'

RSpec.describe Customer, type: :model do
  before :each do 
    @customer_1 = Customer.create!(first_name: "Sally" last_name: "Shopper")
    @customer_2 = Customer.create!(first_name: "Evan" last_name: "East")
    @customer_3 = Customer.create!(first_name: "Yasha" last_name: "West")
    @customer_4 = Customer.create!(first_name: "Du" last_name: "North")
    @customer_5 = Customer.create!(first_name: "Polly" last_name: "South")
    @transaction_1 = 
  end

  describe 'relationships' do
    it {should have_many(:invoices)}
  end

  describe 'model methods' do
    it 'has top 5 customers' do 
      expect(Customer.top_five).to eq("Sally Shopper")
    end
  end
end
