require 'rails_helper'

RSpec.describe Customer, type: :model do
  before :each do 
    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
    @customer_2 = Customer.create!(first_name: "Evan", last_name: "East")
    @customer_3 = Customer.create!(first_name: "Yasha", last_name: "West")
    @customer_4 = Customer.create!(first_name: "Du", last_name: "North")
    @customer_5 = Customer.create!(first_name: "Polly", last_name: "South")
  end

  describe 'relationships' do
    it {should have_many(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end
end