require 'rails_helper'

describe InvoiceItem do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end
end
