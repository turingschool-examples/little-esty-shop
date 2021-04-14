require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    # @merchant_1 = FactoryBot.create(:merchant)
    # @merchant_2 = FactoryBot.create(:merchant)
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
