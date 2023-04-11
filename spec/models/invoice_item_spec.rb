require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end