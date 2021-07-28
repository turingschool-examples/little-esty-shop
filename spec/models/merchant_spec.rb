require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    # it { should belong_to(:) }
    it { should have_many(:items) }
    # it { should have_many(:).through(:) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end

  # before :each do
    
  # end

  # describe 'class methods' do
  #  describe '.' do
  #   end
  # end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end