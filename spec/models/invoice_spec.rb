require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end
end
