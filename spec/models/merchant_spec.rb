require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  it 'can find enabled merchants' do
    merchant1 = Merchant.create(name: 'John', status: 'Enabled')
    merchant2 = Merchant.create(name: 'Jill', status: 'Enabled')
    merchant3 = Merchant.create(name: 'Beth', status: 'Disabled')
    merchant4 = Merchant.create(name: 'Kieth', status: 'Disabled')
    expect(Merchant.enabled_merchants).to eq([merchant1, merchant2])
  end

  it 'can find disabled_merchants' do
    merchant1 = Merchant.create(name: 'John', status: 'Enabled')
    merchant2 = Merchant.create(name: 'Jill', status: 'Enabled')
    merchant3 = Merchant.create(name: 'Beth', status: 'Disabled')
    merchant4 = Merchant.create(name: 'Kieth', status: 'Disabled')
    expect(Merchant.disabled_merchants).to eq([merchant3, merchant4])
  end
end
