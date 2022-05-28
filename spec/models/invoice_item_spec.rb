require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }

    it { should validate_precense_of(:first_name) }
    it { should validate_precense_of(:last_name) }
  end
end
