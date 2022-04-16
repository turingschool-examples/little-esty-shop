require "rails_helper"

RSpec.describe Item do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should belong_to(:merchant) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10065,
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32098,
      created_at: Date.current,
      updated_at: Date.current
    )
    @beer = @merchant_1.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 199,
      created_at: Date.current,
      updated_at: Date.current
    )
  end

  describe 'instance methods' do
    it '#to_dollars tranlates unit price to a float' do
      expect(@cup.to_dollars).to eq(100.65)
      expect(@soccer.to_dollars).to eq(320.98)
      expect(@beer.to_dollars).to eq(1.99)
    end
  end
end
