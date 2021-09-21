require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  it 'can return the customers first and last name together' do
    customer_1 = Customer.create!(first_name: 'Bob', last_name: 'Johnson')
    expect(customer_1.full_name).to eq('Bob Johnson')
  end
end
