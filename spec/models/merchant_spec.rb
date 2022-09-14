require 'rails_helper'
RSpec.describe Merchant, type: :model do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200, enabled: true) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500, enabled: true) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900, enabled: false) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200, enabled: false) }
  
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before(:each) do
    # @instance_var = Something.create!(input)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
       #method goes here
      end
    end

    describe '#enabled_items' do
      it 'returns an array of enabled items' do
        expect(carly.enabled_items).to eq([licorice, peanut])
      end
    end

    describe '#disabled_items' do
      it 'returns an array of enabled items' do
        expect(carly.disabled_items).to eq([choco_waffle, hummus])
      end
    end
  end

  describe 'instance methods' do
    describe '#method_name' do
     it 'description of method' do
      #expect statement here
     end
    end
  end

end