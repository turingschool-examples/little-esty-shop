require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    context ':first_name' do
      it { should validate_presence_of(:first_name) }
    end

    context ':last_name' do
      it { should validate_presence_of(:first_name) }
    end
  end

  it 'returns top 5 customers with most number of successful transactions' do
    expected = [@customer5, @customer7, @customer10, @customer1, @customer9]

    expect(Customer.top_5_customers).to eq(expected)
    # expect(Customer.top_5_customers.count).to eq(5)
  end
end
