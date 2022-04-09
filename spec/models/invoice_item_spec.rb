require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice)}
    it { should belong_to(:item)}
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
