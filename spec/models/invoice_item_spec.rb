require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    # it { should have_many(:) }
    # it { should have_many(:).through(:) }
  end

  describe 'enum status' do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
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
