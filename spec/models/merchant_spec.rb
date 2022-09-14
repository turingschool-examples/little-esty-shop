require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items}
  end

  it 'instantiates with Factorybot' do
    merchant = create(:merchant)
    
  end
end