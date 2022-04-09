require 'rails_helper'

RSpec.describe Item do
  before :each do
    @merchant = Merchant.create!(name: "Frank's Pudding",
                           created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                           updated_at: Time.parse('2012-03-27 14:53:59 UTC'))

    @item = @merchant.items.create!(name: 'Chocolate Delight', unit_price: 500,
                             description: 'tastiest chocolate pudding on the east coast',
                              created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                              updated_at: Time.parse('2012-03-27 14:53:59 UTC'))
  end

  context 'readable attributes' do
    it 'has a name' do
      expect(@item.name).to eq("Chocolate Delight")
    end

    it 'has a description' do
      expect(@item.description).to eq('tastiest chocolate pudding on the east coast')
    end
  end

  context 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  context 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoices, through: :invoice_items}
  end
end
