require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoices).through(:items)}
  it { should validate_presence_of(:name)}

  before :each do
    test_data
  end

  describe "#enabled" do
    it "enables merchant status" do
      merchant = Merchant.create!(name: 'Jimothy', status: 'disabled')
      merchant.enabled!

      expect(merchant.status).to eq('enabled')
    end
  end

  describe "#disabled" do
    it "enables merchant status" do
      merchant = Merchant.create!(name: 'Jimothy', status: 'enabled')
      merchant.disabled!

      expect(merchant.status).to eq('disabled')
    end
  end
end
