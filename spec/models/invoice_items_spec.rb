require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:unit_price).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }

    let!(:status) { %i[packaged pending shipped]}
  end

end
