require 'rails_helper'
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    #should we put validations here?
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
    describe '#format_' do
     it 'description of method' do #make a method to format date and time
      #expect statement here
     end
    end
  end

end