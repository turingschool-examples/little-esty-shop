require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validation' do
    it { should define_enum_for(:status).with([:packaged, :pending, :shipped]) }
  end

  describe 'relations' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end
