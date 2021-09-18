require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
    #it {should validate_presence_of :id}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end
end
