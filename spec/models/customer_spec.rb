require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  it 'exists' do
    customer = create(:customer)

    expect(customer).to be_a(Customer)
    expect(customer).to be_valid
  end

  describe 'relationships' do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices) }
  end
end
