require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'associations' do
    it {should belong_to :merchant}
    it {should have_many(:items).through(:merchant) }
    it {should have_many(:invoice_items).through(:items) }
    it {should have_many(:invoices).through(:invoice_items) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :threshold }
    it { should validate_numericality_of(:percentage).only_integer }
    it { should validate_numericality_of(:percentage).is_less_than_or_equal_to(100) }
    it { should validate_numericality_of(:threshold).only_integer }
    it { should validate_numericality_of(:threshold).is_less_than_or_equal_to(100) }
  end
end
