require 'rails_helper'

RSpec.describe Merchant do
  before(:each) do
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
