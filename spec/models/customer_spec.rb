require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'instance methods' do
    it 'has full name' do
      customer = Customer.create!(first_name: "John", last_name: "Elway")
      expect(customer.full_name).to eq("John Elway")
    end
  end
end