require 'rails_helper'
describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({packaged: 0, pending: 1, shipped: 2})}
  end
end
