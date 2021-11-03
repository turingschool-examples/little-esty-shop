require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'model methods' do
    it 'returns full name' do
      customer = create(:customer)
      expect(customer.full_name).to eq(customer.first_name + " " + customer.last_name)
    end
  end
end
