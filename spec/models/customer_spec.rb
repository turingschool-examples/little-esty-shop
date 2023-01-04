require 'rails_helper'

RSpec.describe Customer, type: :model do

  before(:all) do
    Rails.application.load_seed
  end

  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  it 'has a method to find the top 5 customers by successful invoices' do
    result = [Customer.third, Customer.fifth, Customer.second, Customer.fourth, Customer.last]
    expect(Customer.top_5_transactions).to eq(result)

  end
end