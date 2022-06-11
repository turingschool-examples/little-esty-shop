require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'Relationships' do
    it { should belong_to :merchant }

    end

  describe 'Validations' do
    it {should validate_presence_of :threshold }
    it {should validate_presence_of :discount_percentage }
    it { should validate_numericality_of(:threshold).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:discount_percentage).is_less_than(100) }
    it { should validate_numericality_of(:discount_percentage).is_greater_than(0) }

  end
end
