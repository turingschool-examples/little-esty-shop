require 'rails_helper'

describe Item do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many(:invoices).through(:invoice_items)}
  end
end
