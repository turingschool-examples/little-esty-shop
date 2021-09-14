require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:merchant_invoices) }
    it { should have_many(:invoices).through(:merchant_invoices) }
  end
end
