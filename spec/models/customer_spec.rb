require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    let(:customer) { create :customer }

    it 'should respond to invoices' do
      expect(customer).to respond_to(:invoices)
    end
  end
end
