require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity)}
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(["Pending", "Packaged", "Shipped"])}
  end

  describe 'relationships' do
    it { should belong_to :item}
    it { should belong_to :invoice}
  end
end