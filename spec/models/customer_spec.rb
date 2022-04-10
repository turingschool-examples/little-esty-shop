require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end
  describe 'instance and class methods' do
    it '#full_name' do
      customer_1 = Customer.create!(first_name: 'Boss', last_name: 'Man', created_at: Time.now, updated_at: Time.now)
      expect(customer_1.full_name).to eq('Boss Man')
    end
  end
end
