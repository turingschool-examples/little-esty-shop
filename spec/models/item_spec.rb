require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:invoices)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  before :each do
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do
    
  end
end