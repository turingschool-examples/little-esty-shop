require 'rails_helper'

RSpec.describe Customer, type: :model do
  let!(:customer) { Customer.create!(first_name: "A Name", last_name: "A Last Name") }
  describe 'the customer model' do
    it { should have_many :invoices }
    
    it 'exists' do
      expect(customer).to be_a(Customer)      
      expect(customer.first_name).to eq("A Name")      
      expect(customer.last_name).to eq("A Last Name")      
    end
  end
end