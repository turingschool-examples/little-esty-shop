require 'rails_helper'
describe Customer, type: :model do
  describe 'relationships' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should have_many :invoices }
  end

  describe 'instance and class methods' do
    it '#full_name' do
      customer_1 = Customer.create!(first_name: 'Seth', last_name: 'Perna')
      expect(customer_1.full_name).to eq('Seth Perna')
    end
  end
end
