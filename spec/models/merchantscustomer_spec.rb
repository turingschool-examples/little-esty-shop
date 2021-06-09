require 'rails_helper'

RSpec.describe MerchantsCustomer, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
  end
end
