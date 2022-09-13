require "rails_helper"


RSpec.describe(Item, type: :model) do
  let(:item) { Item.new(name: "Qui Esse", description: "Nihil autem", unit_price: 32301, merchant_id: 1) }

  it "is an instance of item" do
    expect(item).to be_instance_of(Item)
  end
end
