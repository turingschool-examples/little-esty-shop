require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }

    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end
end
