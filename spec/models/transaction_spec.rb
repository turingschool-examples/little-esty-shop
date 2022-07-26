require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:result) }
    it { should validate_numericality_of(:result) }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  before :each do
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do
    
  end
end