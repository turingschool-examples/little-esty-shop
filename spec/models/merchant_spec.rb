require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  before :each do
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do
    
  end
end