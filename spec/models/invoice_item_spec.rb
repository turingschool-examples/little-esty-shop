require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should define_enum_for(:status) }
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  before :each do

  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
