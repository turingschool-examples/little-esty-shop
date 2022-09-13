require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new(first_name: "Joey", last_name: "T") }

  describe 'relationships' do
    it {should have_many(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  it 'is an instance of customer' do
    expect(customer).to be_instance_of(Customer)
  end
end