require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new(first_name: "Joey", last_name: "T") }

  it 'is an instance of customer' do
    expect(customer).to be_instance_of(Customer)
  end
end