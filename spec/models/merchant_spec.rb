require "rails_helper"

RSpec.describe(Merchant, type: :model) do
  let(:merchant) { Merchant.new(name: "David Marks") }

  it("is an instance of merchant") do
    expect(merchant).to(be_instance_of(Merchant))
  end
end