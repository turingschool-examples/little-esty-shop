require 'rails_helper'

RSpec.describe Transaction do
  before(:each) do
  end

  describe 'relationships' do
    it {should belong_to :invoice}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
