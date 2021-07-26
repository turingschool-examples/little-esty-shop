require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
  end
end
