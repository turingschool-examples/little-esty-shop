require 'rails_helper'

RSpec.describe MerchantsCustomer, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoices).through(:customer) }
    it { should have_many(:transactions).through(:invoices) }
  end
end
