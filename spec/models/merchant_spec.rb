require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it {should have_many :items}
  end
end
