require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should define_enum_for(:status).with_values(["pending", "packaged", "shipped"])}
  end
end
