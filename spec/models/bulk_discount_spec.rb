require 'rails_helper'
RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:percentage_discount) }
    it { should validate_presence_of(:percentage_discount) }
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:quantity_threshold, :inclusion => 1..100 )}
  end

  before(:each) do
    # @instance_var = Something.create!(input)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
       #method goes here
      end
    end
  end

  describe 'instance methods' do
    describe '#method_name' do
     it 'description of method' do
      #expect statement here
     end
    end
  end

end