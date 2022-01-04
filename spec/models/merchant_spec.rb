require 'rails_helper'
describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end
end
