require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'associations' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:unit_price).only_integer }
    it { should define_enum_for(:status).with_values([:packaged, :pending, :shipped]) }

  end
end
