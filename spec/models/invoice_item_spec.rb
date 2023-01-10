require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
    it {should have_one(:merchant).through(:item)}
    it {should have_one(:customer).through(:invoice)}
    it {should have_many(:transactions).through(:invoice)}
  end
end