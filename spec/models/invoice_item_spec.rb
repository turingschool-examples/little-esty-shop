require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should define_enum_for(:status).with_values(["packaged", "pending", "shipped"])}
  end
end
