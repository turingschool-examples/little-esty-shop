require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :id}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class_methods' do
    it 'returns a list of all enabled merchants' do
      merchant_1 = Merchant.create!(name: "Bob",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant_2 = Merchant.create!(name: "Sara",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC", status: 'disabled')
      merchant_3= Merchant.create!(name: "Bill",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant_4 = Merchant.create!(name: "Sam",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC", status: 'disabled')
      expect(Merchant.enabled_list).to eq([merchant_1,merchant_3 ])
    end
    it 'returns a list of all enabled merchants' do
      merchant_1 = Merchant.create!(name: "Bob",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant_2 = Merchant.create!(name: "Sara",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC", status: 'disabled')
      merchant_3= Merchant.create!(name: "Bill",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant_4 = Merchant.create!(name: "Sam",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC", status: 'disabled')
      expect(Merchant.disabled_list).to eq([merchant_2, merchant_4])
    end
  end
end
