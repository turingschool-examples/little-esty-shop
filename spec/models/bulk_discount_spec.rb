require 'rails_helper'
RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    # it { should have_many(:) }
    # it { should have_many(:).through(:) }
  end
  describe 'validations' do
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:quantity_threshold) }
  end
  before :each do

  end
  describe 'class methods' do
    describe '.' do
    end
  end
  describe 'instance methods' do
    describe '#' do
    end
  end
end
