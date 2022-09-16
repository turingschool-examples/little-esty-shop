require "rails_helper"

RSpec.describe(Item, type: :model) do
  let(:item) { Item.new(name: "Qui Esse", description: "Nihil autem", unit_price: 32301, merchant_id: 1) }

  it "is an instance of item" do
    expect(item).to be_instance_of(Item)
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
  end
end
