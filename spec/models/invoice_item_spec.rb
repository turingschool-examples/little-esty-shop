require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity)}
    it { should validate_numericality_of(:unit_price)}
    it { should define_enum_for(:status).with([
      :pending, :packaged, :shipped ])}
  end

  describe 'relationships' do
    it { should belong_to(:invoice)}
    it { should belong_to(:item)}
  end
end
