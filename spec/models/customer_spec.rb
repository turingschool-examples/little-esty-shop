require 'rails_helper'

RSpec.describe Customer do
  before(:each) do
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
