require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'Relationships' do
    it { should belong_to :merchant }

    end

    describe 'Validations' do
        it {should validate_numericality_of(:discount_percentage).is_greater_than(0)}
    end

end
