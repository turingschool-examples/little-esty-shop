require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  # before :each do
  #
  # end
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
